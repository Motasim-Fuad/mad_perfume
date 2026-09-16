import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/error/api_exception.dart';
import 'package:madperfume/core/models/catalog_models.dart';
import 'package:madperfume/core/models/commerce_models.dart';
import 'package:madperfume/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:madperfume/features/commerce/data/commerce_repository.dart';
import 'package:madperfume/features/orders/data/reviewed_product_store.dart';
import 'package:uuid/uuid.dart';

class CheckoutState extends Equatable {
  const CheckoutState({
    this.useCard = false,
    this.loading = false,
    this.error = '',
  });

  final bool useCard;
  final bool loading;
  final String error;

  CheckoutState copyWith({bool? useCard, bool? loading, String? error}) {
    return CheckoutState(
      useCard: useCard ?? this.useCard,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [useCard, loading, error];
}

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this._orders, this._cart, this.profile)
    : super(const CheckoutState()) {
    name.text = profile?.fullName ?? '';
    address.text = profile?.shippingAddress ?? '';
    phone.text = profile?.phone ?? '';
  }

  final OrderRepository _orders;
  final CartCubit _cart;
  final ProfileModel? profile;
  final name = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();
  final phone = TextEditingController();
  String? _idempotencyKey;

  void setCard(bool value) => emit(state.copyWith(useCard: value, error: ''));

  Future<void> place() async {
    if (name.text.trim().isEmpty ||
        address.text.trim().isEmpty ||
        city.text.trim().isEmpty) {
      emit(state.copyWith(error: 'fill_shipping'.tr));
      return;
    }
    if (state.useCard) {
      emit(state.copyWith(error: 'stripe_unavailable'.tr));
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
        idempotencyKey: _idempotencyKey,
      );
      await _cart.load(silent: true);
      emit(state.copyWith(loading: false));
      Get.offNamed(AppRoutes.orderSuccess, arguments: order.id);
    } on ApiException catch (error) {
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
