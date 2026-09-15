import 'package:get/get.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/core/constants/storage_keys.dart';
import 'package:madperfume/core/services/storage_service.dart';
import 'package:madperfume/features/auth/data/models/user_model.dart';
import 'package:madperfume/features/cart/data/models/cart_item.dart';
import 'package:madperfume/features/loyalty/data/models/points_entry.dart';
import 'package:madperfume/features/orders/data/models/order_model.dart';

class SessionStore extends GetxService {
  SessionStore(this._storage);

  final StorageService _storage;

  final user = Rxn<UserModel>();
  final token = ''.obs;
  final cart = <CartItem>[].obs;
  final wishlist = <String>[].obs;
  final orders = <OrderModel>[].obs;
  final points = 1250.obs;
  final history = <PointsEntry>[].obs;
  final redeemed = <String>[].obs;
  final promoOffers = true.obs;
  final exclusiveReleases = true.obs;
  final memberUpdates = false.obs;

  bool get isLoggedIn => token.value.isNotEmpty && user.value != null;

  void load() {
    token.value = _storage.read<String>(StorageKeys.token) ?? '';
    final map = _storage.readMap(StorageKeys.user);
    if (map != null) {
      user.value = UserModel.fromJson(map);
    }
    cart.assignAll(
      _storage.readList(StorageKeys.cart).whereType<Map>().map((item) {
        return CartItem.fromJson(Map<String, dynamic>.from(item));
      }),
    );
    wishlist.assignAll(
      _storage.readList(StorageKeys.wishlist).map((item) => item.toString()),
    );
    orders.assignAll(
      _storage.readList(StorageKeys.orders).whereType<Map>().map((item) {
        return OrderModel.fromJson(Map<String, dynamic>.from(item));
      }),
    );
    points.value = _storage.read<int>(StorageKeys.points) ?? 1250;
    history.assignAll(
      _storage.readList(StorageKeys.pointsHistory).whereType<Map>().map((item) {
        return PointsEntry.fromJson(Map<String, dynamic>.from(item));
      }),
    );
    if (history.isEmpty) {
      history.assignAll(const [
        PointsEntry(
          id: 'seed-1',
          title: 'Welcome privilege',
          points: 1250,
          type: PointsType.earned,
          date: 'Sep 01, 2026',
        ),
      ]);
    }
    redeemed.assignAll(
      _storage.readList(StorageKeys.redeemedRewards).map((item) => item.toString()),
    );
    final prefs = _storage.readMap(StorageKeys.notificationsPrefs);
    if (prefs != null) {
      promoOffers.value = prefs['promo'] as bool? ?? true;
      exclusiveReleases.value = prefs['exclusive'] as bool? ?? true;
      memberUpdates.value = prefs['member'] as bool? ?? false;
    }
  }

  Future<void> persistAuth(String access, UserModel model) async {
    token.value = access;
    user.value = model;
    await _storage.write(StorageKeys.token, access);
    await _storage.write(StorageKeys.user, model.toJson());
  }

  Future<void> clearAuth() async {
    token.value = '';
    user.value = null;
    cart.clear();
    wishlist.clear();
    await _storage.remove(StorageKeys.token);
    await _storage.remove(StorageKeys.user);
    await _persistCart();
    await _persistWishlist();
  }

  Future<void> updateUser(UserModel model) async {
    user.value = model;
    await _storage.write(StorageKeys.user, model.toJson());
  }

  bool isSaved(String productId) => wishlist.contains(productId);

  Future<void> toggleSaved(String productId) async {
    if (wishlist.contains(productId)) {
      wishlist.remove(productId);
    } else {
      wishlist.add(productId);
    }
    await _persistWishlist();
  }

  Future<void> addToCart(ProductEntityRef item, {int qty = 1}) async {
    final index = cart.indexWhere((entry) => entry.productId == item.productId);
    if (index >= 0) {
      final current = cart[index];
      cart[index] = current.copyWith(quantity: current.quantity + qty);
    } else {
      cart.add(
        CartItem(
          productId: item.productId,
          name: item.name,
          volume: item.volume,
          imageUrl: item.imageUrl,
          price: item.price,
          collectionId: item.collectionId,
          quantity: qty,
        ),
      );
    }
    await _persistCart();
  }

  Future<void> setQty(String productId, int qty) async {
    if (qty <= 0) {
      cart.removeWhere((item) => item.productId == productId);
    } else {
      final index = cart.indexWhere((item) => item.productId == productId);
      if (index >= 0) {
        cart[index] = cart[index].copyWith(quantity: qty);
      }
    }
    await _persistCart();
  }

  Future<void> clearCart() async {
    cart.clear();
    await _persistCart();
  }

  double get cartTotal => cart.fold(0, (sum, item) => sum + item.lineTotal);

  int get cartCount => cart.fold(0, (sum, item) => sum + item.quantity);

  int earnPointsForCart() {
    var total = 0;
    for (final item in cart) {
      final collection = CatalogData.collectionById(item.collectionId);
      total += collection.earnPoints * item.quantity;
    }
    return total;
  }

  int maxApplicablePoints(double payable) {
    final cap = (payable / CatalogData.usdPerPoint).floor();
    if (cap < 0) {
      return 0;
    }
    return cap < points.value ? cap : points.value;
  }

  Future<OrderModel> checkout({
    required String fullName,
    required String address,
    required String city,
    required String paymentMethod,
    required int pointsUsed,
    required String cardMasked,
  }) async {
    final subtotal = cartTotal;
    final tax = subtotal * 0.07;
    final shipping = 0.0;
    final used = pointsUsed.clamp(0, maxApplicablePoints(subtotal + tax + shipping)).toInt();
    final discount = used * CatalogData.usdPerPoint;
    final total = (subtotal + tax + shipping - discount).clamp(0, double.infinity).toDouble();
    final earned = earnPointsForCart();
    final id = 'MD-${1000 + orders.length + 21}';
    final order = OrderModel(
      id: id,
      items: List<CartItem>.from(cart),
      subtotal: subtotal,
      tax: tax,
      shipping: shipping,
      discount: discount,
      total: total,
      pointsUsed: used,
      pointsEarned: earned,
      fullName: fullName,
      address: '$address, $city',
      city: city,
      paymentMethod: paymentMethod,
      cardMasked: cardMasked,
      status: OrderStatus.inTransit,
      createdAt: DateTime.now(),
      eta: DateTime.now().add(const Duration(days: 9)),
    );
    orders.insert(0, order);
    points.value = points.value - used + earned;
    if (used > 0) {
      history.insert(
        0,
        PointsEntry(
          id: 'sp-$id',
          title: 'Checkout $id',
          points: used,
          type: PointsType.spent,
          date: _fmt(DateTime.now()),
        ),
      );
    }
    if (earned > 0) {
      history.insert(
        0,
        PointsEntry(
          id: 'en-$id',
          title: 'Collection earn $id',
          points: earned,
          type: PointsType.earned,
          date: _fmt(DateTime.now()),
        ),
      );
    }
    await clearCart();
    await _persistOrders();
    await _persistPoints();
    return order;
  }

  Future<void> markReviewed(String orderId, String productId) async {
    final index = orders.indexWhere((item) => item.id == orderId);
    if (index < 0) {
      return;
    }
    final order = orders[index];
    if (order.reviewedProductIds.contains(productId)) {
      return;
    }
    orders[index] = order.copyWith(
      reviewedProductIds: [...order.reviewedProductIds, productId],
    );
    orders.refresh();
    await _persistOrders();
  }

  Future<String?> redeemReward(RewardEntityRef reward) async {
    if (redeemed.contains(reward.id)) {
      return 'already_redeemed';
    }
    if (points.value < reward.points) {
      return 'not_enough_points';
    }
    points.value -= reward.points;
    redeemed.add(reward.id);
    history.insert(
      0,
      PointsEntry(
        id: 'rw-${reward.id}',
        title: reward.title,
        points: reward.points,
        type: PointsType.spent,
        date: _fmt(DateTime.now()),
      ),
    );
    await _persistPoints();
    return null;
  }

  Future<void> persistPrefs() async {
    await _storage.write(StorageKeys.notificationsPrefs, {
      'promo': promoOffers.value,
      'exclusive': exclusiveReleases.value,
      'member': memberUpdates.value,
    });
  }

  Future<void> _persistCart() =>
      _storage.writeJson(StorageKeys.cart, cart.map((item) => item.toJson()).toList());

  Future<void> _persistWishlist() => _storage.write(StorageKeys.wishlist, wishlist.toList());

  Future<void> _persistOrders() =>
      _storage.writeJson(StorageKeys.orders, orders.map((item) => item.toJson()).toList());

  Future<void> _persistPoints() async {
    await _storage.write(StorageKeys.points, points.value);
    await _storage.writeJson(
      StorageKeys.pointsHistory,
      history.map((item) => item.toJson()).toList(),
    );
    await _storage.write(StorageKeys.redeemedRewards, redeemed.toList());
  }

  String _fmt(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

class ProductEntityRef {
  const ProductEntityRef({
    required this.productId,
    required this.name,
    required this.volume,
    required this.imageUrl,
    required this.price,
    required this.collectionId,
  });

  final String productId;
  final String name;
  final String volume;
  final String imageUrl;
  final double price;
  final String collectionId;
}

class RewardEntityRef {
  const RewardEntityRef({
    required this.id,
    required this.title,
    required this.points,
  });

  final String id;
  final String title;
  final int points;
}
