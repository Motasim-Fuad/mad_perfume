import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/error/api_exception.dart';
import 'package:madperfume/core/models/catalog_models.dart';
import 'package:madperfume/core/models/commerce_models.dart';
import 'package:madperfume/core/models/loyalty_models.dart';
import 'package:madperfume/core/network/paginated.dart';
import 'package:madperfume/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:madperfume/features/commerce/data/commerce_repository.dart';
import 'package:madperfume/features/loyalty/data/loyalty_repository.dart';
import 'package:madperfume/features/orders/data/reviewed_product_store.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CheckoutState extends Equatable {
  const CheckoutState({
    this.useCard = false,
    this.loading = false,
    this.error = '',
    this.vouchers = const [],
    this.vouchersLoading = false,
    this.voucherError = '',
    this.selectedVoucher,
  });

  final bool useCard;
  final bool loading;
  final String error;
  final List<RedemptionModel> vouchers;
  final bool vouchersLoading;
  final String voucherError;
  final RedemptionModel? selectedVoucher;

  CheckoutState copyWith({
    bool? useCard,
    bool? loading,
    String? error,
    List<RedemptionModel>? vouchers,
    bool? vouchersLoading,
    String? voucherError,
    RedemptionModel? selectedVoucher,
    bool clearVoucher = false,
  }) {
    return CheckoutState(
      useCard: useCard ?? this.useCard,
      loading: loading ?? this.loading,
      error: error ?? this.error,
      vouchers: vouchers ?? this.vouchers,
      vouchersLoading: vouchersLoading ?? this.vouchersLoading,
      voucherError: voucherError ?? this.voucherError,
      selectedVoucher: clearVoucher
          ? null
          : (selectedVoucher ?? this.selectedVoucher),
    );
  }

  @override
  List<Object?> get props => [
    useCard,
    loading,
    error,
    vouchers,
    vouchersLoading,
    voucherError,
    selectedVoucher?.voucherCode,
  ];
}

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this._orders, this._cart, this._loyalty, this.profile)
    : super(const CheckoutState()) {
    name.text = profile?.fullName ?? '';
    address.text = profile?.shippingAddress ?? '';
    phone.text = profile?.phone ?? '';
    loadVouchers();
  }

  final OrderRepository _orders;
  final CartCubit _cart;
  final LoyaltyRepository _loyalty;
  final ProfileModel? profile;
  final name = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();
  final phone = TextEditingController();
  String? _idempotencyKey;

  void setCard(bool value) => emit(state.copyWith(useCard: value, error: ''));

  void selectVoucher(RedemptionModel? voucher) {
    final same = voucher?.voucherCode == state.selectedVoucher?.voucherCode;
    _idempotencyKey = null;
    emit(
      state.copyWith(
        selectedVoucher: voucher,
        clearVoucher: voucher == null || same,
        error: '',
      ),
    );
  }

  Future<void> refreshAll() async {
    await Future.wait([_cart.load(), loadVouchers()]);
  }

  Future<void> loadVouchers() async {
    emit(state.copyWith(vouchersLoading: true, voucherError: ''));
    try {
      final walletAndRewards = await Future.wait([
        _loyalty.redemptions(),
        _loyalty.rewards(),
      ]);
      var usable = <RedemptionModel>[];
      try {
        usable = (await _loyalty.redemptions(usable: true)).results;
      } on ApiException {
        usable = const [];
      }
      if (isClosed) {
        return;
      }
      final wallet =
          (walletAndRewards[0] as Paginated<RedemptionModel>).results;
      final rewards = walletAndRewards[1] as List<RewardModel>;
      final byReward = {for (final reward in rewards) reward.id: reward};
      final vouchers = _checkoutVouchers(
        usable: usable,
        wallet: wallet,
        byReward: byReward,
      );
      final selected = state.selectedVoucher;
      final stillThere =
          selected != null &&
          vouchers.any((item) => item.voucherCode == selected.voucherCode);
      emit(
        state.copyWith(
          vouchers: vouchers,
          vouchersLoading: false,
          voucherError: '',
          selectedVoucher: stillThere ? selected : null,
          clearVoucher: !stillThere,
        ),
      );
    } on ApiException catch (error) {
      if (isClosed) {
        return;
      }
      emit(state.copyWith(vouchersLoading: false, voucherError: error.message));
    }
  }

  List<RedemptionModel> _checkoutVouchers({
    required List<RedemptionModel> usable,
    required List<RedemptionModel> wallet,
    required Map<int, RewardModel> byReward,
  }) {
    final merged = <String, RedemptionModel>{};
    for (final item in [...usable, ...wallet]) {
      if (!item.isUnused) {
        continue;
      }
      final reward = byReward[item.reward];
      final amount = item.resolvedDiscount > 0
          ? item.resolvedDiscount
          : (reward?.discountAmount ?? 0);
      final checkoutVoucher =
          amount > 0 ||
          (reward?.isCheckoutVoucher ?? false) ||
          item.name.toLowerCase().contains('voucher');
      if (!checkoutVoucher) {
        continue;
      }
      merged[item.voucherCode] = item.copyWith(
        discountAmount: amount > 0 ? amount : item.discountAmount,
      );
    }
    return merged.values.toList();
  }

  Future<void> place() async {
    if (name.text.trim().isEmpty ||
        address.text.trim().isEmpty ||
        city.text.trim().isEmpty) {
      emit(state.copyWith(error: 'fill_shipping'.tr));
      return;
    }
    emit(state.copyWith(loading: true, error: ''));
    _idempotencyKey ??= const Uuid().v4();
    try {
      final order = await _orders.place(
        shippingName: name.text.trim(),
        shippingAddress: address.text.trim(),
        shippingCity: city.text.trim(),
        shippingPhone: phone.text.trim(),
        paymentMethod: state.useCard ? 'card' : 'cod',
        voucherCode: state.selectedVoucher?.voucherCode,
        idempotencyKey: _idempotencyKey,
      );
      if (state.useCard) {
        if (order.clientSecret == null || order.clientSecret!.isEmpty) {
          emit(state.copyWith(loading: false, error: 'stripe_unavailable'.tr));
          return;
        }
        try {
          await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: order.clientSecret!,
              merchantDisplayName: 'MAD Perfume',
            ),
          );
          await Stripe.instance.presentPaymentSheet();
        } on StripeException catch (error) {
          if (isClosed) {
            return;
          }
          emit(
            state.copyWith(
              loading: false,
              error: error.error.localizedMessage ?? 'stripe_unavailable'.tr,
            ),
          );
          return;
        }
      }
      await _cart.load(silent: true);
      if (isClosed) {
        return;
      }
      emit(state.copyWith(loading: false));
      Get.offNamed(AppRoutes.orderSuccess, arguments: order.id);
    } on ApiException catch (error) {
      if (isClosed) {
        return;
      }
      emit(state.copyWith(loading: false, error: error.message));
    }
  }

  @override
  Future<void> close() {
    name.dispose();
    address.dispose();
    city.dispose();
    phone.dispose();
    return super.close();
  }
}

class OrdersState extends Equatable {
  const OrdersState({
    this.items = const [],
    this.loading = true,
    this.error = '',
  });

  final List<OrderModel> items;
  final bool loading;
  final String error;

  @override
  List<Object?> get props => [items, loading, error];
}

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this._orders) : super(const OrdersState());

  final OrderRepository _orders;

  Future<void> load() async {
    emit(const OrdersState(loading: true));
    try {
      final page = await _orders.list();
      emit(OrdersState(items: page.results, loading: false));
    } on ApiException catch (error) {
      emit(OrdersState(loading: false, error: error.message));
    }
  }
}

class OrderDetailState extends Equatable {
  const OrderDetailState({
    this.order,
    this.reviewedProductIds = const {},
    this.loading = true,
    this.error = '',
  });

  final OrderModel? order;
  final Set<int> reviewedProductIds;
  final bool loading;
  final String error;

  @override
  List<Object?> get props => [order, reviewedProductIds, loading, error];
}

class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit(this._orders, this._reviewedStore, this.userId, this.orderId)
    : super(const OrderDetailState());

  final OrderRepository _orders;
  final ReviewedProductStore _reviewedStore;
  final int userId;
  final int orderId;

  Future<void> load() async {
    emit(const OrderDetailState(loading: true));
    try {
      final order = await _orders.detail(orderId);
      emit(
        OrderDetailState(
          order: order,
          reviewedProductIds: _reviewedStore.read(userId),
          loading: false,
        ),
      );
    } on ApiException catch (error) {
      emit(OrderDetailState(loading: false, error: error.message));
    }
  }

  void track() => Get.toNamed(AppRoutes.orderTracking, arguments: orderId);

  void home() => Get.offAllNamed(AppRoutes.main);

  Future<void> review(int productId) async {
    final reviewed = await Get.toNamed<bool>(
      AppRoutes.writeReview,
      arguments: {'productId': productId, 'orderId': orderId},
    );
    if (reviewed == true) {
      emit(
        OrderDetailState(
          order: state.order,
          reviewedProductIds: {...state.reviewedProductIds, productId},
          loading: false,
        ),
      );
    }
  }
}
