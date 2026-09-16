import 'package:madperfume/core/constants/api_endpoints.dart';
import 'package:madperfume/core/models/commerce_models.dart';
import 'package:madperfume/core/network/api_client.dart';
import 'package:madperfume/core/network/paginated.dart';
import 'package:uuid/uuid.dart';

class CartRepository {
  CartRepository(this._api);

  final ApiClient _api;

  Future<CartModel> getCart() {
    return _api.get(
      ApiEndpoints.cart,
      parse: (data) => CartModel.fromJson(_map(data)),
    );
  }

  Future<CartLineModel> add({required int productId, int quantity = 1}) {
    return _api.post(
      ApiEndpoints.cart,
      data: {'product': productId, 'quantity': quantity},
      parse: (data) => CartLineModel.fromJson(_map(data)),
    );
  }

  Future<CartLineModel> setQuantity({
    required int itemId,
    required int quantity,
  }) {
    return _api.patch(
      ApiEndpoints.cartItem(itemId),
      data: {'quantity': quantity},
      parse: (data) => CartLineModel.fromJson(_map(data)),
    );
  }

  Future<void> remove(int itemId) {
    return _api.delete(ApiEndpoints.cartItem(itemId));
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

class OrderRepository {
  OrderRepository(this._api);

  final ApiClient _api;
  final _uuid = const Uuid();

  Future<OrderModel> place({
    required String shippingName,
    required String shippingAddress,
    required String shippingCity,
    String? shippingPhone,
    required String paymentMethod,
    String? voucherCode,
    String? idempotencyKey,
  }) {
    final key = idempotencyKey ?? _uuid.v4();
    return _api.post(
      ApiEndpoints.orders,
      data: {
        'shipping_name': shippingName,
        'shipping_address': shippingAddress,
        'shipping_city': shippingCity,
        if (shippingPhone != null && shippingPhone.isNotEmpty)
          'shipping_phone': shippingPhone,
        'payment_method': paymentMethod,
        if (voucherCode != null && voucherCode.isNotEmpty)
          'voucher_code': voucherCode,
      },
      headers: {'Idempotency-Key': key},
      parse: (data) => OrderModel.fromJson(_map(data)),
    );
  }

  Future<Paginated<OrderModel>> list({int page = 1}) {
    return _api.get(
      ApiEndpoints.orders,
      query: {'page': page},
      parse: (data) => Paginated.fromJson(_map(data), OrderModel.fromJson),
    );
  }

  Future<OrderModel> detail(int id) {
    return _api.get(
      ApiEndpoints.order(id),
      parse: (data) => OrderModel.fromJson(_map(data)),
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
