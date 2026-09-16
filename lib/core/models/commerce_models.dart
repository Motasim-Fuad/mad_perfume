import 'package:madperfume/core/utils/json_read.dart';

class CartLineModel {
  const CartLineModel({
    required this.id,
    required this.product,
    required this.name,
    required this.categoryName,
    required this.variant,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.lineTotal,
  });

  final int id;
  final int product;
  final String name;
  final String categoryName;
  final String variant;
  final double price;
  final String imageUrl;
  final int quantity;
  final double lineTotal;

  factory CartLineModel.fromJson(Map<String, dynamic> json) {
    return CartLineModel(
      id: JsonRead.integer(json['id']),
      product: JsonRead.integer(json['product']),
      name: JsonRead.text(json['name']),
      categoryName: JsonRead.text(json['category_name']),
      variant: JsonRead.text(json['variant']),
      price: JsonRead.money(json['price']),
      imageUrl: JsonRead.text(json['image_url']),
      quantity: JsonRead.integer(json['quantity'], 1),
      lineTotal: JsonRead.money(json['line_total']),
    );
  }
}

class CartModel {
  const CartModel({
    required this.items,
    required this.itemsCount,
    required this.subtotal,
  });

  final List<CartLineModel> items;
  final int itemsCount;
  final double subtotal;

  static const empty = CartModel(items: [], itemsCount: 0, subtotal: 0);

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final raw = json['items'];
    final items = raw is List
        ? raw
              .whereType<Map>()
              .map(
                (item) =>
                    CartLineModel.fromJson(Map<String, dynamic>.from(item)),
              )
              .toList()
        : <CartLineModel>[];
    return CartModel(
      items: items,
      itemsCount: JsonRead.integer(
        json['items_count'],
        items.fold<int>(0, (sum, item) => sum + item.quantity),
      ),
      subtotal: JsonRead.money(json['subtotal']),
    );
  }
}

class OrderItemModel {
  const OrderItemModel({
    required this.name,
    required this.variant,
    required this.quantity,
    required this.price,
    required this.lineTotal,
    required this.notes,
    this.product,
  });

  final int? product;
  final String name;
  final String variant;
  final int quantity;
  final double price;
  final double lineTotal;
  final List<String> notes;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      product: JsonRead.integerOrNull(json['product']),
      name: JsonRead.text(json['name']),
      variant: JsonRead.text(json['variant']),
      quantity: JsonRead.integer(json['quantity'], 1),
      price: JsonRead.money(json['price']),
      lineTotal: JsonRead.money(json['line_total']),
      notes: JsonRead.strings(json['notes']),
    );
  }
}

class OrderEventModel {
  const OrderEventModel({required this.status, required this.createdAt});

  final String status;
  final String createdAt;

  factory OrderEventModel.fromJson(Map<String, dynamic> json) {
    return OrderEventModel(
      status: JsonRead.text(json['status']),
      createdAt: JsonRead.text(json['created_at']),
    );
  }
}

class OrderModel {
  const OrderModel({
    required this.id,
    required this.number,
    required this.status,
    required this.items,
    required this.events,
    required this.subtotal,
    this.discount = 0,
    required this.tax,
    required this.shippingFee,
    required this.total,
    required this.estimatedDelivery,
    required this.shippingName,
    required this.shippingAddress,
    required this.shippingCity,
    required this.paymentMethod,
    this.clientSecret,
    this.cardLast4,
  });

  final int id;
  final String number;
  final String status;
  final List<OrderItemModel> items;
  final List<OrderEventModel> events;
  final double subtotal;
  final double discount;
  final double tax;
  final double shippingFee;
  final double total;
  final String estimatedDelivery;
  final String shippingName;
  final String shippingAddress;
  final String shippingCity;
  final String paymentMethod;
  final String? clientSecret;
  final String? cardLast4;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final items = json['items'] is List
        ? (json['items'] as List)
              .whereType<Map>()
              .map(
                (item) =>
                    OrderItemModel.fromJson(Map<String, dynamic>.from(item)),
              )
              .toList()
        : <OrderItemModel>[];
    final events = json['events'] is List
        ? (json['events'] as List)
              .whereType<Map>()
              .map(
                (item) =>
                    OrderEventModel.fromJson(Map<String, dynamic>.from(item)),
              )
              .toList()
        : <OrderEventModel>[];
    final secret = json['client_secret']?.toString();
    return OrderModel(
      id: JsonRead.integer(json['id']),
      number: JsonRead.text(json['number']),
      status: JsonRead.text(json['status']),
      items: items,
      events: events,
      subtotal: JsonRead.money(json['subtotal']),
      discount: JsonRead.money(json['discount']),
      tax: JsonRead.money(json['tax']),
      shippingFee: JsonRead.money(json['shipping_fee']),
      total: JsonRead.money(json['total']),
      estimatedDelivery: JsonRead.text(json['estimated_delivery']),
      shippingName: JsonRead.text(json['shipping_name']),
      shippingAddress: JsonRead.text(json['shipping_address']),
      shippingCity: JsonRead.text(json['shipping_city']),
      paymentMethod: JsonRead.text(json['payment_method']),
      clientSecret: secret == null || secret.isEmpty || secret == 'null'
          ? null
          : secret,
      cardLast4: json['card_last4']?.toString(),
    );
  }
}
