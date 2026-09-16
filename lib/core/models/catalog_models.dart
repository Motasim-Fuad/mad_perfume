import 'package:madperfume/core/utils/json_read.dart';

class ProfileModel {
  const ProfileModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.shippingAddress,
    required this.avatarUrl,
    required this.language,
    required this.pushEnabled,
    required this.notifyCollections,
    required this.notifyRewards,
    required this.notifyOrders,
    required this.pointsBalance,
    required this.tier,
  });

  final int id;
  final String fullName;
  final String email;
  final String phone;
  final String shippingAddress;
  final String avatarUrl;
  final String language;
  final bool pushEnabled;
  final bool notifyCollections;
  final bool notifyRewards;
  final bool notifyOrders;
  final int pointsBalance;
  final String tier;

  String get firstName {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    return parts.isEmpty ? fullName : parts.first;
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: JsonRead.integer(json['id']),
      fullName: JsonRead.text(json['full_name']),
      email: JsonRead.text(json['email']),
      phone: JsonRead.text(json['phone']),
      shippingAddress: JsonRead.text(json['shipping_address']),
      avatarUrl: JsonRead.text(json['avatar_url']),
      language: JsonRead.text(json['language']).isEmpty
          ? 'en'
          : JsonRead.text(json['language']),
      pushEnabled: JsonRead.flag(json['push_enabled'], true),
      notifyCollections: JsonRead.flag(json['notify_collections'], true),
      notifyRewards: JsonRead.flag(json['notify_rewards'], true),
      notifyOrders: JsonRead.flag(json['notify_orders'], true),
      pointsBalance: JsonRead.integer(json['points_balance']),
      tier: JsonRead.text(json['tier']),
    );
  }
}

class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.imageUrl,
  });

  final int id;
  final String name;
  final String type;
  final String description;
  final String imageUrl;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: JsonRead.integer(json['id']),
      name: JsonRead.text(json['name']),
      type: JsonRead.text(json['type']),
      description: JsonRead.text(json['description']),
      imageUrl: JsonRead.text(json['image_url']),
    );
  }
}

class BannerModel {
  const BannerModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.startsOn,
    required this.endsOn,
  });

  final int id;
  final String title;
  final String imageUrl;
  final String startsOn;
  final String endsOn;

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: JsonRead.integer(json['id']),
      title: JsonRead.text(json['title']),
      imageUrl: JsonRead.text(json['image_url']),
      startsOn: JsonRead.text(json['starts_on']),
      endsOn: JsonRead.text(json['ends_on']),
    );
  }
}

class ProductBranchRef {
  const ProductBranchRef({
    required this.id,
    required this.name,
    required this.city,
  });

  final int id;
  final String name;
  final String city;

  factory ProductBranchRef.fromJson(Map<String, dynamic> json) {
    return ProductBranchRef(
      id: JsonRead.integer(json['id']),
      name: JsonRead.text(json['name']),
      city: JsonRead.text(json['city']),
    );
  }
}

class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.categoryName,
    required this.concentration,
    required this.size,
    required this.notes,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.reviewsCount,
    required this.isSaved,
    required this.inStock,
    this.description = '',
    this.imageUrls = const [],
    this.branches = const [],
  });

  final int id;
  final String name;
  final String brand;
  final int category;
  final String categoryName;
  final String concentration;
  final String size;
  final List<String> notes;
  final double price;
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final bool isSaved;
  final bool inStock;
  final String description;
  final List<String> imageUrls;
  final List<ProductBranchRef> branches;

  String get concentrationLabel => concentration.replaceAll('_', ' ');

  ProductModel copyWith({bool? isSaved}) {
    return ProductModel(
      id: id,
      name: name,
      brand: brand,
      category: category,
      categoryName: categoryName,
      concentration: concentration,
      size: size,
      notes: notes,
      price: price,
      imageUrl: imageUrl,
      rating: rating,
      reviewsCount: reviewsCount,
      isSaved: isSaved ?? this.isSaved,
      inStock: inStock,
      description: description,
      imageUrls: imageUrls,
      branches: branches,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final urls = JsonRead.strings(json['image_urls']);
    final rawBranches = json['branches'];
    return ProductModel(
      id: JsonRead.integer(json['id']),
      name: JsonRead.text(json['name']),
      brand: JsonRead.text(json['brand']),
      category: JsonRead.integer(json['category']),
      categoryName: JsonRead.text(json['category_name']),
      concentration: JsonRead.text(json['concentration']),
      size: JsonRead.text(json['size']),
      notes: JsonRead.strings(json['notes']),
      price: JsonRead.money(json['price']),
      imageUrl: JsonRead.text(json['image_url']),
      rating: json['rating'] is num ? (json['rating'] as num).toDouble() : 0,
      reviewsCount: JsonRead.integer(json['reviews_count']),
      isSaved: JsonRead.flag(json['is_saved']),
      inStock: JsonRead.flag(json['in_stock'], true),
      description: JsonRead.text(json['description']),
      imageUrls: urls.isEmpty ? [JsonRead.text(json['image_url'])] : urls,
      branches: rawBranches is List
          ? rawBranches
                .whereType<Map>()
                .map(
                  (item) => ProductBranchRef.fromJson(
                    Map<String, dynamic>.from(item),
                  ),
                )
                .toList()
          : const [],
    );
  }
}

class ReviewModel {
  const ReviewModel({
    required this.id,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  final int id;
  final String userName;
  final int rating;
  final String comment;
  final String createdAt;

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: JsonRead.integer(json['id']),
      userName: JsonRead.text(json['user_name']),
      rating: JsonRead.integer(json['rating']),
      comment: JsonRead.text(json['comment']),
      createdAt: JsonRead.text(json['created_at']),
    );
  }
}

class BranchModel {
  const BranchModel({
    required this.id,
    required this.name,
    required this.isFlagship,
    required this.address,
    required this.city,
    required this.country,
    required this.phone,
    required this.email,
    required this.weekdayOpens,
    required this.weekdayCloses,
    required this.sundayOpens,
    required this.sundayCloses,
    required this.imageUrl,
  });

  final int id;
  final String name;
  final bool isFlagship;
  final String address;
  final String city;
  final String country;
  final String phone;
  final String email;
  final String weekdayOpens;
  final String weekdayCloses;
  final String sundayOpens;
  final String sundayCloses;
  final String imageUrl;

  String get hours {
    return 'Weekdays $weekdayOpens – $weekdayCloses\nSunday $sundayOpens – $sundayCloses';
  }

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: JsonRead.integer(json['id']),
      name: JsonRead.text(json['name']),
      isFlagship: JsonRead.flag(json['is_flagship']),
      address: JsonRead.text(json['address']),
      city: JsonRead.text(json['city']),
      country: JsonRead.text(json['country']),
      phone: JsonRead.text(json['phone']),
      email: JsonRead.text(json['email']),
      weekdayOpens: JsonRead.text(json['weekday_opens']),
      weekdayCloses: JsonRead.text(json['weekday_closes']),
      sundayOpens: JsonRead.text(json['sunday_opens']),
      sundayCloses: JsonRead.text(json['sunday_closes']),
      imageUrl: JsonRead.text(json['image_url']),
    );
  }
}
