import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/error/api_exception.dart';
import 'package:madperfume/core/models/commerce_models.dart';
import 'package:madperfume/features/commerce/data/commerce_repository.dart';

class CartState extends Equatable {
  const CartState({
    this.cart = CartModel.empty,
    this.loading = false,
    this.error = '',
  });

  final CartModel cart;
  final bool loading;
  final String error;

  CartState copyWith({CartModel? cart, bool? loading, String? error}) {
    return CartState(
      cart: cart ?? this.cart,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [cart, loading, error];
}

class CartCubit extends Cubit<CartState> {
  CartCubit(this._repository) : super(const CartState());

  final CartRepository _repository;

  Future<void> load({bool silent = false}) async {
    if (!silent) {
      emit(state.copyWith(loading: true, error: ''));
    }
    try {
      final cart = await _repository.getCart();
      emit(state.copyWith(cart: cart, loading: false, error: ''));
    } on ApiException catch (error) {
      emit(state.copyWith(loading: false, error: error.message));
    }
  }

  Future<void> add(int productId, {int quantity = 1}) async {
    emit(state.copyWith(error: ''));
    try {
      await _repository.add(productId: productId, quantity: quantity);
      await load(silent: true);
    } on ApiException catch (error) {
      emit(state.copyWith(error: error.message));
      rethrow;
    }
  }

  Future<void> setQty(int itemId, int quantity) async {
    if (quantity < 1) {
      await remove(itemId);
      return;
    }
    try {
      await _repository.setQuantity(itemId: itemId, quantity: quantity);
      await load(silent: true);
    } on ApiException catch (error) {
      emit(state.copyWith(error: error.message));
    }
  }

  Future<void> remove(int itemId) async {
    try {
      await _repository.remove(itemId);
      await load(silent: true);
    } on ApiException catch (error) {
      emit(state.copyWith(error: error.message));
    }
  }

  void checkout() {
    if (state.cart.items.isEmpty) {
      return;
    }
    Get.toNamed(AppRoutes.checkout);
  }
}
