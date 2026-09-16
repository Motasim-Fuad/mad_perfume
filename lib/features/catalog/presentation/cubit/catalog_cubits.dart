import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/error/api_exception.dart';
import 'package:madperfume/core/models/catalog_models.dart';
import 'package:madperfume/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:madperfume/features/catalog/data/catalog_repository.dart';

class CategoryState extends Equatable {
  const CategoryState({
    this.items = const [],
    this.loading = true,
    this.error = '',
  });

  final List<CategoryModel> items;
  final bool loading;
  final String error;

  @override
  List<Object?> get props => [items, loading, error];
}

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this._catalog) : super(const CategoryState());

  final CatalogRepository _catalog;

  Future<void> load() async {
    emit(const CategoryState(loading: true));
    try {
      final items = await _catalog.categories();
      emit(CategoryState(items: items, loading: false));
    } on ApiException catch (error) {
      emit(CategoryState(loading: false, error: error.message));
    }
  }

  void open(int id) => Get.toNamed(AppRoutes.productList, arguments: id);
}

class ProductListState extends Equatable {
  const ProductListState({
    this.items = const [],
    this.loading = true,
    this.error = '',
    this.categoryName = '',
  });

  final List<ProductModel> items;
  final bool loading;
  final String error;
  final String categoryName;

  @override
  List<Object?> get props => [items, loading, error, categoryName];
}

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit(this._catalog, this.categoryId)
    : super(const ProductListState());

  final CatalogRepository _catalog;
  final int categoryId;
  String _search = '';
  bool _newest = true;

  Future<void> load({String? search, bool? newest}) async {
    if (search != null) {
      _search = search.trim();
    }
    if (newest != null) {
      _newest = newest;
    }
    emit(const ProductListState(loading: true));
    try {
      final page = await _catalog.products(
        category: categoryId,
        search: _search.isEmpty ? null : _search,
        ordering: _newest ? '-created_at' : 'price',
      );
      String name = '';
      if (page.results.isNotEmpty) {
        name = page.results.first.categoryName;
      } else {
        final cats = await _catalog.categories();
        name = cats
            .where((item) => item.id == categoryId)
            .map((item) => item.name)
            .firstWhere((item) => item.isNotEmpty, orElse: () => '');
      }
      emit(
        ProductListState(
          items: page.results,
          loading: false,
          categoryName: name,
        ),
      );
    } on ApiException catch (error) {
      emit(ProductListState(loading: false, error: error.message));
    }
  }

  bool get newest => _newest;

  Future<void> toggleSort() => load(newest: !_newest);

  void open(int id) => Get.toNamed(AppRoutes.productDetails, arguments: id);
}

class ProductDetailsState extends Equatable {
  const ProductDetailsState({
    this.product,
    this.reviews = const [],
    this.loading = true,
    this.busy = false,
    this.error = '',
  });

  final ProductModel? product;
  final List<ReviewModel> reviews;
  final bool loading;
  final bool busy;
  final String error;

  @override
  List<Object?> get props => [product, reviews, loading, busy, error];
}

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this._catalog, this._cart, this.productId)
    : super(const ProductDetailsState());

  final CatalogRepository _catalog;
  final CartCubit _cart;
  final int productId;

  Future<void> load() async {
    emit(const ProductDetailsState(loading: true));
    try {
      final product = await _catalog.product(productId);
      final reviews = await _catalog.reviews(productId);
      emit(
        ProductDetailsState(
          product: product,
          reviews: reviews.results,
          loading: false,
        ),
      );
    } on ApiException catch (error) {
      emit(ProductDetailsState(loading: false, error: error.message));
    }
  }

  Future<void> toggleSaved() async {
    final product = state.product;
    if (product == null) {
      return;
    }
    try {
      if (product.isSaved) {
        await _catalog.unsave(product.id);
      } else {
        await _catalog.save(product.id);
      }
      emit(
        ProductDetailsState(
          product: product.copyWith(isSaved: !product.isSaved),
          reviews: state.reviews,
          loading: false,
        ),
      );
    } on ApiException catch (error) {
      emit(
        ProductDetailsState(
          product: product,
          reviews: state.reviews,
          loading: false,
          error: error.message,
        ),
      );
    }
  }

  Future<void> addToCart() async {
    final product = state.product;
    if (product == null || !product.inStock || state.busy) {
      return;
    }
    emit(
      ProductDetailsState(
        product: product,
        reviews: state.reviews,
        loading: false,
        busy: true,
      ),
    );
    try {
      await _cart.add(product.id);
      emit(
        ProductDetailsState(
          product: product,
          reviews: state.reviews,
          loading: false,
        ),
      );
    } on ApiException catch (error) {
      emit(
        ProductDetailsState(
          product: product,
          reviews: state.reviews,
          loading: false,
          error: error.message,
        ),
      );
    }
  }
}

class SearchState extends Equatable {
  const SearchState({
    this.query = '',
    this.items = const [],
    this.loading = false,
    this.error = '',
  });

  final String query;
  final List<ProductModel> items;
  final bool loading;
  final String error;

  @override
  List<Object?> get props => [query, items, loading, error];
}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._catalog) : super(const SearchState());

  final CatalogRepository _catalog;

  Future<void> search(String query) async {
    emit(SearchState(query: query, loading: true));
    try {
      final page = await _catalog.products(
        search: query.trim().isEmpty ? null : query.trim(),
      );
      emit(SearchState(query: query, items: page.results, loading: false));
    } on ApiException catch (error) {
      emit(SearchState(query: query, loading: false, error: error.message));
    }
  }

  void open(int id) => Get.toNamed(AppRoutes.productDetails, arguments: id);
}
