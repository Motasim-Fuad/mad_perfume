import 'package:madperfume/features/cart/data/models/cart_item.dart';

enum OrderStatus { placed, processing, shipped, inTransit, delivered }

class OrderModel {
  const OrderModel({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.shipping,
    required this.discount,
    required this.total,
    required this.pointsUsed,
    required this.pointsEarned,
    required this.fullName,
    required this.address,
    required this.city,
    required this.paymentMethod,
    required this.cardMasked,
    required this.status,
    required this.createdAt,
    required this.eta,
    this.reviewedProductIds = const [],
  });

  final String id;
  final List<CartItem> items;
  final double subtotal;
  final double tax;
  final double shipping;
  final double discount;
  final double total;
  final int pointsUsed;
  final int pointsEarned;
  final String fullName;
  final String address;
  final String city;
  final String paymentMethod;
  final String cardMasked;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime eta;
  final List<String> reviewedProductIds;

  OrderModel copyWith({
    OrderStatus? status,
    List<String>? reviewedProductIds,
  }) {
    return OrderModel(
      id: id,
      items: items,
      subtotal: subtotal,
      tax: tax,
      shipping: shipping,
      discount: discount,
      total: total,
      pointsUsed: pointsUsed,
      pointsEarned: pointsEarned,
      fullName: fullName,
      address: address,
      city: city,
      paymentMethod: paymentMethod,
      cardMasked: cardMasked,
      status: status ?? this.status,
      createdAt: createdAt,
      eta: eta,
      reviewedProductIds: reviewedProductIds ?? this.reviewedProductIds,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'items': items.map((item) => item.toJson()).toList(),
        'subtotal': subtotal,
        'tax': tax,
        'shipping': shipping,
        'discount': discount,
        'total': total,
        'pointsUsed': pointsUsed,
        'pointsEarned': pointsEarned,
        'fullName': fullName,
        'address': address,
        'city': city,
        'paymentMethod': paymentMethod,
        'cardMasked': cardMasked,
        'status': status.name,
        'createdAt': createdAt.toIso8601String(),
        'eta': eta.toIso8601String(),
        'reviewedProductIds': reviewedProductIds,
      };

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      items: (json['items'] as List<dynamic>)
          .whereType<Map>()
          .map((item) => CartItem.fromJson(Map<String, dynamic>.from(item)))
          .toList(),
      subtotal: (json['subtotal'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      shipping: (json['shipping'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      pointsUsed: json['pointsUsed'] as int,
      pointsEarned: json['pointsEarned'] as int,
      fullName: json['fullName'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      paymentMethod: json['paymentMethod'] as String,
      cardMasked: json['cardMasked'] as String? ?? '',
      status: OrderStatus.values.firstWhere(
        (value) => value.name == json['status'],
        orElse: () => OrderStatus.inTransit,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      eta: DateTime.parse(json['eta'] as String),
      reviewedProductIds: (json['reviewedProductIds'] as List<dynamic>? ?? const [])
          .map((item) => item.toString())
          .toList(),
    );
  }
}
