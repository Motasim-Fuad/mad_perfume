import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/error/api_exception.dart';
import 'package:madperfume/core/models/catalog_models.dart';
import 'package:madperfume/core/models/commerce_models.dart';
import 'package:madperfume/core/utils/validators.dart';
import 'package:madperfume/features/auth/data/auth_repository.dart';
import 'package:madperfume/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:madperfume/features/catalog/data/catalog_repository.dart';
import 'package:madperfume/features/commerce/data/commerce_repository.dart';

class ProfileHomeState extends Equatable {
  const ProfileHomeState({
    this.orders = const [],
    this.savedCount = 0,
    this.loading = true,
    this.error = '',
  });

  final List<OrderModel> orders;
  final int savedCount;
  final bool loading;
  final String error;

  @override
  List<Object?> get props => [orders, savedCount, loading, error];
}

class ProfileHomeCubit extends Cubit<ProfileHomeState> {
  ProfileHomeCubit(this._orders, this._catalog)
    : super(const ProfileHomeState());

  final OrderRepository _orders;
  final CatalogRepository _catalog;

  Future<void> load() async {
    emit(const ProfileHomeState(loading: true));
    try {
      final orders = await _orders.list();
      final saved = await _catalog.saved();
      emit(
        ProfileHomeState(
          orders: orders.results,
          savedCount: saved.count,
          loading: false,
        ),
      );
    } on ApiException catch (error) {
      emit(ProfileHomeState(loading: false, error: error.message));
    }
  }

  void openSettings() => Get.toNamed(AppRoutes.settings);
  void openSaved() => Get.toNamed(AppRoutes.savedItems);
  void openAllOrders() => Get.toNamed(AppRoutes.allOrders);
  void openOrder(int id) => Get.toNamed(AppRoutes.orderDetails, arguments: id);
}

class EditProfileCubit extends Cubit<({bool loading, String error})> {
  EditProfileCubit(this._authCubit, ProfileModel profile)
    : super((loading: false, error: '')) {
    name.text = profile.fullName;
    email.text = profile.email;
    phone.text = profile.phone;
    address.text = profile.shippingAddress;
  }

  final AuthCubit _authCubit;
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();

  Future<void> save() async {
    if (name.text.trim().isEmpty) {
      emit((loading: false, error: 'required_field'.tr));
      return;
    }
    emit((loading: true, error: ''));
    try {
      final profile = await _authCubit.patchProfile({
        'full_name': name.text.trim(),
        'email': email.text.trim(),
        'phone': phone.text.trim(),
        'shipping_address': address.text.trim(),
      });
      if (profile == null) {
        emit((loading: false, error: _authCubit.state.error));
        return;
      }
      emit((loading: false, error: ''));
      Get.back();
    } on ApiException catch (error) {
      emit((loading: false, error: error.message));
    }
  }

  @override
  Future<void> close() {
    name.dispose();
    email.dispose();
    phone.dispose();
    address.dispose();
    return super.close();
  }
}

class SecurityCubit extends Cubit<({bool loading, String error})> {
  SecurityCubit(this._auth, this._authCubit)
    : super((loading: false, error: ''));

  final AuthRepository _auth;
  final AuthCubit _authCubit;
  final current = TextEditingController();
  final next = TextEditingController();
  final confirm = TextEditingController();

  Future<void> updatePassword() async {
    final passError =
        Validators.password(next.text, 'invalid_password'.tr) ??
        Validators.confirm(confirm.text, next.text, 'password_mismatch'.tr);
    if (passError != null) {
      emit((loading: false, error: passError));
      return;
    }
    emit((loading: true, error: ''));
    try {
      await _auth.changePassword(current: current.text, next: next.text);
      emit((loading: false, error: ''));
      await _authCubit.logout();
    } on ApiException catch (error) {
      emit((loading: false, error: error.message));
    }
  }

  @override
  Future<void> close() {
    current.dispose();
    next.dispose();
    confirm.dispose();
    return super.close();
  }
}

class PrefsCubit extends Cubit<({bool loading, String error})> {
  PrefsCubit(this._authCubit) : super((loading: false, error: ''));

  final AuthCubit _authCubit;

  Future<void> setNotify({
    bool? collections,
    bool? rewards,
    bool? orders,
  }) async {
    final profile = _authCubit.state.profile;
    if (profile == null) {
      return;
    }
    final updated = await _authCubit.patchProfile({
      'notify_collections': collections ?? profile.notifyCollections,
      'notify_rewards': rewards ?? profile.notifyRewards,
      'notify_orders': orders ?? profile.notifyOrders,
    });
    if (updated == null) {
      emit((loading: false, error: _authCubit.state.error));
    }
  }
}

class SavedCubit
    extends Cubit<({List<ProductModel> items, bool loading, String error})> {
  SavedCubit(this._catalog)
    : super((items: const [], loading: true, error: ''));

  final CatalogRepository _catalog;

  Future<void> load() async {
    emit((items: const [], loading: true, error: ''));
    try {
      final page = await _catalog.saved();
      emit((items: page.results, loading: false, error: ''));
    } on ApiException catch (error) {
      emit((items: const [], loading: false, error: error.message));
    }
  }
}

class BranchesState extends Equatable {
  const BranchesState({
    this.items = const [],
    this.loading = true,
    this.error = '',
  });

  final List<BranchModel> items;
  final bool loading;
  final String error;

  @override
  List<Object?> get props => [items, loading, error];
}

class BranchesCubit extends Cubit<BranchesState> {
  BranchesCubit(this._catalog) : super(const BranchesState());

  final CatalogRepository _catalog;

  Future<void> search(String query) async {
    emit(const BranchesState(loading: true));
    try {
      final page = await _catalog.branches(
        search: query.trim().isEmpty ? null : query.trim(),
      );
      emit(BranchesState(items: page.results, loading: false));
    } on ApiException catch (error) {
      emit(BranchesState(loading: false, error: error.message));
    }
  }

  void open(int id) => Get.toNamed(AppRoutes.branchDetails, arguments: id);
}

class BranchDetailCubit
    extends Cubit<({BranchModel? branch, bool loading, String error})> {
  BranchDetailCubit(this._catalog, this.id)
    : super((branch: null, loading: true, error: ''));

  final CatalogRepository _catalog;
  final int id;

  Future<void> load() async {
    emit((branch: null, loading: true, error: ''));
    try {
      final branch = await _catalog.branch(id);
      emit((branch: branch, loading: false, error: ''));
    } on ApiException catch (error) {
      emit((branch: null, loading: false, error: error.message));
    }
  }
}

class WriteReviewCubit
    extends Cubit<({int rating, bool loading, String error})> {
  WriteReviewCubit(this._catalog, this.productId)
    : super((rating: 5, loading: false, error: ''));

  final CatalogRepository _catalog;
  final int productId;
  final body = TextEditingController();

  void setRating(int value) =>
      emit((rating: value, loading: false, error: state.error));

  Future<void> submit() async {
    if (body.text.trim().isEmpty) {
      emit((rating: state.rating, loading: false, error: 'review_hint'.tr));
      return;
    }
    emit((rating: state.rating, loading: true, error: ''));
    try {
      await _catalog.writeReview(
        productId: productId,
        rating: state.rating,
        comment: body.text.trim(),
      );
      emit((rating: state.rating, loading: false, error: ''));
      Get.back();
    } on ApiException catch (error) {
      emit((rating: state.rating, loading: false, error: error.message));
    }
  }

  @override
  Future<void> close() {
    body.dispose();
    return super.close();
  }
}
