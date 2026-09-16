import 'dart:async';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/error/api_exception.dart';
import 'package:madperfume/core/models/catalog_models.dart';
import 'package:madperfume/core/models/commerce_models.dart';
import 'package:madperfume/core/utils/validators.dart';
import 'package:madperfume/features/auth/data/auth_repository.dart';
import 'package:madperfume/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:madperfume/features/catalog/data/catalog_repository.dart';
import 'package:madperfume/features/commerce/data/commerce_repository.dart';
import 'package:madperfume/features/orders/data/reviewed_product_store.dart';
import 'package:madperfume/features/loyalty/presentation/cubit/loyalty_cubits.dart';

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

class EditProfileCubit
    extends Cubit<({bool loading, String error, Uint8List? avatarBytes})> {
  EditProfileCubit(this._authCubit, ProfileModel profile)
    : super((loading: false, error: '', avatarBytes: null)) {
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
  XFile? _avatar;

  Future<void> pickAvatar() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 88,
    );
    if (image == null) {
      return;
    }
    final extension = image.name.split('.').last.toLowerCase();
    final validType = {'png', 'jpg', 'jpeg', 'webp'}.contains(extension);
    final validSize = await image.length() <= 10 * 1024 * 1024;
    if (!validType || !validSize) {
      emit((
        loading: false,
        error: 'invalid_avatar'.tr,
        avatarBytes: state.avatarBytes,
      ));
      return;
    }
    _avatar = image;
    emit((loading: false, error: '', avatarBytes: await image.readAsBytes()));
  }

  Future<void> save() async {
    if (name.text.trim().isEmpty) {
      emit((
        loading: false,
        error: 'required_field'.tr,
        avatarBytes: state.avatarBytes,
      ));
      return;
    }
    emit((loading: true, error: '', avatarBytes: state.avatarBytes));
    try {
      final profile = await _authCubit.patchProfile({
        'full_name': name.text.trim(),
        'email': email.text.trim(),
        'phone': phone.text.trim(),
        'shipping_address': address.text.trim(),
      });
      if (profile == null) {
        emit((
          loading: false,
          error: _authCubit.state.error,
          avatarBytes: state.avatarBytes,
        ));
        return;
      }
      if (_avatar != null) {
        final uploaded = await _authCubit.uploadAvatar(_avatar!);
        if (uploaded == null) {
          emit((
            loading: false,
            error: _authCubit.state.error,
            avatarBytes: state.avatarBytes,
          ));
          return;
        }
      }
      emit((loading: false, error: '', avatarBytes: state.avatarBytes));
      Get.back();
    } on ApiException catch (error) {
      emit((
        loading: false,
        error: error.message,
        avatarBytes: state.avatarBytes,
      ));
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
  Timer? _debounce;
  int _generation = 0;

  void search(String query) {
    _debounce?.cancel();
    final generation = ++_generation;
    _debounce = Timer(
      const Duration(milliseconds: 350),
      () => _load(query, generation),
    );
  }

  Future<void> searchNow(String query) async {
    _debounce?.cancel();
    final generation = ++_generation;
    await _load(query, generation);
  }

  Future<void> _load(String query, int generation) async {
    emit(const BranchesState(loading: true));
    try {
      final page = await _catalog.branches(
        search: query.trim().isEmpty ? null : query.trim(),
      );
      if (generation == _generation) {
        emit(BranchesState(items: page.results, loading: false));
      }
    } on ApiException catch (error) {
      if (generation == _generation) {
        emit(BranchesState(loading: false, error: error.message));
      }
    }
  }

  void open(int id) => Get.toNamed(AppRoutes.branchDetails, arguments: id);

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
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
  WriteReviewCubit(
    this._catalog,
    this._reviewedStore,
    this._authCubit,
    this.userId,
    this.productId,
  ) : super((rating: 5, loading: false, error: ''));

  final CatalogRepository _catalog;
  final ReviewedProductStore _reviewedStore;
  final AuthCubit _authCubit;
  final int userId;
  final int productId;
  final body = TextEditingController();

  void setRating(int value) =>
      emit((rating: value, loading: false, error: state.error));

  Future<void> submit() async {
    emit((rating: state.rating, loading: true, error: ''));
    try {
      await _catalog.writeReview(
        productId: productId,
        rating: state.rating,
        comment: body.text.trim(),
      );
      await _reviewedStore.mark(userId: userId, productId: productId);
      await _authCubit.refreshProfile();
      await LoyaltyCubit.instance?.load();
      emit((rating: state.rating, loading: false, error: ''));
      Get.back(result: true);
    } on ApiException catch (error) {
      if (error.message.toLowerCase().contains('already reviewed')) {
        await _reviewedStore.mark(userId: userId, productId: productId);
        Get.back(result: true);
        return;
      }
      emit((rating: state.rating, loading: false, error: error.message));
    }
  }

  @override
  Future<void> close() {
    body.dispose();
    return super.close();
  }
}
