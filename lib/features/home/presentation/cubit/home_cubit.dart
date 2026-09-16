import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/error/api_exception.dart';
import 'package:madperfume/core/models/catalog_models.dart';
import 'package:madperfume/features/catalog/data/catalog_repository.dart';
import 'package:madperfume/features/shell/presentation/cubit/shell_cubit.dart';
import 'package:madperfume/shared/widgets/language_selector_widget.dart';

class HomeState extends Equatable {
  const HomeState({
    this.banners = const [],
    this.categories = const [],
    this.featured = const [],
    this.branches = const [],
    this.loading = true,
    this.error = '',
  });

  final List<BannerModel> banners;
  final List<CategoryModel> categories;
  final List<ProductModel> featured;
  final List<BranchModel> branches;
  final bool loading;
  final String error;

  HomeState copyWith({
    List<BannerModel>? banners,
    List<CategoryModel>? categories,
    List<ProductModel>? featured,
    List<BranchModel>? branches,
    bool? loading,
    String? error,
  }) {
    return HomeState(
      banners: banners ?? this.banners,
      categories: categories ?? this.categories,
      featured: featured ?? this.featured,
      branches: branches ?? this.branches,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    banners,
    categories,
    featured,
    branches,
    loading,
    error,
  ];
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._catalog) : super(const HomeState());

  final CatalogRepository _catalog;

  Future<void> load() async {
    emit(state.copyWith(loading: true, error: ''));
    try {
      final banners = await _catalog.banners();
      final categories = await _catalog.categories();
      final featured = await _catalog.products(featured: true);
      final branches = await _catalog.branches();
      emit(
        state.copyWith(
          loading: false,
          banners: banners,
          categories: categories,
          featured: featured.results,
          branches: branches.results.take(4).toList(),
        ),
      );
    } on ApiException catch (error) {
      emit(state.copyWith(loading: false, error: error.message));
    }
  }

  Future<void> toggleSaved(ProductModel product) async {
    try {
      if (product.isSaved) {
        await _catalog.unsave(product.id);
      } else {
        await _catalog.save(product.id);
      }
      emit(
        state.copyWith(
          featured: state.featured
              .map(
                (item) => item.id == product.id
                    ? item.copyWith(isSaved: !item.isSaved)
                    : item,
              )
              .toList(),
        ),
      );
    } on ApiException catch (error) {
      emit(state.copyWith(error: error.message));
    }
  }

  void openProduct(int id) =>
      Get.toNamed(AppRoutes.productDetails, arguments: id);

  void openCollection(int id) =>
      Get.toNamed(AppRoutes.productList, arguments: id);

  void openAllCollections() => ShellCubit.instance?.setTab(1);

  void openBranches() => Get.toNamed(AppRoutes.branches);

  void openBranch(int id) =>
      Get.toNamed(AppRoutes.branchDetails, arguments: id);

  void openNotifications() => Get.toNamed(AppRoutes.notifications);

  Future<void> openLanguage() => openLanguageSheet();
}
