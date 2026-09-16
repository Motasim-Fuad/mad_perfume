import 'package:madperfume/core/constants/api_endpoints.dart';
import 'package:madperfume/core/models/catalog_models.dart';
import 'package:madperfume/core/network/api_client.dart';
import 'package:madperfume/core/network/paginated.dart';

class CatalogRepository {
  CatalogRepository(this._api);

  final ApiClient _api;

  Future<List<CategoryModel>> categories() {
    return _api.get(
      ApiEndpoints.categories,
      auth: false,
      parse: (data) {
        if (data is! List) {
          return <CategoryModel>[];
        }
        return data
            .whereType<Map>()
            .map(
              (item) => CategoryModel.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList();
      },
    );
  }

  Future<List<BannerModel>> banners() {
    return _api.get(
      ApiEndpoints.banners,
      auth: false,
      parse: (data) {
        if (data is! List) {
          return <BannerModel>[];
        }
        return data
            .whereType<Map>()
            .map(
              (item) => BannerModel.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList();
      },
    );
  }

  Future<Paginated<ProductModel>> products({
    String? search,
    int? category,
    bool? featured,
    String? ordering,
    int page = 1,
  }) {
    return _api.get(
      ApiEndpoints.products,
      query: {
        'search': search,
        'category': category,
        'is_featured': featured == true ? 'true' : null,
        'ordering': ordering,
        'page': page,
      },
      parse: (data) => Paginated.fromJson(_map(data), ProductModel.fromJson),
    );
  }

  Future<ProductModel> product(int id) {
    return _api.get(
      ApiEndpoints.product(id),
      parse: (data) => ProductModel.fromJson(_map(data)),
    );
  }

  Future<Paginated<ReviewModel>> reviews(int productId, {int page = 1}) {
    return _api.get(
      ApiEndpoints.productReviews(productId),
      auth: false,
      query: {'page': page},
      parse: (data) => Paginated.fromJson(_map(data), ReviewModel.fromJson),
    );
  }

  Future<ReviewModel> writeReview({
    required int productId,
    required int rating,
    required String comment,
  }) {
    return _api.post(
      ApiEndpoints.productReviews(productId),
      data: {'rating': rating, 'comment': comment},
      parse: (data) => ReviewModel.fromJson(_map(data)),
    );
  }

  Future<Paginated<ProductModel>> saved({int page = 1}) {
    return _api.get(
      ApiEndpoints.savedProducts,
      query: {'page': page},
      parse: (data) => Paginated.fromJson(_map(data), ProductModel.fromJson),
    );
  }

  Future<void> save(int productId) {
    return _api.post<void>(
      ApiEndpoints.savedProducts,
      data: {'product': productId},
      parse: (_) {},
    );
  }

  Future<void> unsave(int productId) {
    return _api.delete(ApiEndpoints.savedProduct(productId));
  }

  Future<Paginated<BranchModel>> branches({String? search, int page = 1}) {
    return _api.get(
      ApiEndpoints.branches,
      auth: false,
      query: {'search': search, 'page': page},
      parse: (data) => Paginated.fromJson(_map(data), BranchModel.fromJson),
    );
  }

  Future<BranchModel> branch(int id) {
    return _api.get(
      ApiEndpoints.branch(id),
      auth: false,
      parse: (data) => BranchModel.fromJson(_map(data)),
    );
  }

  Map<String, dynamic> _map(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    return const {};
  }
}
