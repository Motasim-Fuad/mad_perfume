import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/core/services/session_store.dart';
import 'package:madperfume/core/utils/field_wrap.dart';

class CheckoutController extends GetxController {
  CheckoutController();

  final name = FieldWrap();
  final address = FieldWrap();
  final city = FieldWrap();
  final card = FieldWrap();
  final expiry = FieldWrap();
  final useCard = true.obs;
  final usePoints = false.obs;
  final loading = false.obs;
  final error = ''.obs;

  SessionStore get session => Get.find<SessionStore>();

  @override
  void onInit() {
    final user = session.user.value;
    name.controller.text = user?.fullName ?? '';
    address.controller.text = user?.address ?? '';
    city.controller.text = 'Paris';
    super.onInit();
  }

  @override
  void onClose() {
    name.dispose();
    address.dispose();
    city.dispose();
    card.dispose();
    expiry.dispose();
    super.onClose();
  }

  int get applicable => session.maxApplicablePoints(session.cartTotal * 1.07);

  int get pointsToUse => usePoints.value ? applicable : 0;

  double get subtotal => session.cartTotal;

  double get tax => subtotal * 0.07;

  double get discount => pointsToUse * CatalogData.usdPerPoint;

  double get total => (subtotal + tax - discount).clamp(0, double.infinity).toDouble();

  Future<void> placeOrder() async {
    error.value = '';
    if (name.controller.text.trim().isEmpty ||
        address.controller.text.trim().isEmpty ||
        city.controller.text.trim().isEmpty) {
      error.value = 'fill_shipping'.tr;
      return;
    }
    if (useCard.value) {
      final digits = card.controller.text.replaceAll(RegExp(r'\D'), '');
      if (digits.length < 12) {
        error.value = 'card_invalid'.tr;
        return;
      }
      if (expiry.controller.text.trim().length < 4) {
        error.value = 'expiry_invalid'.tr;
        return;
      }
    }
    loading.value = true;
    try {
      final digits = card.controller.text.replaceAll(RegExp(r'\D'), '');
      final masked = digits.length >= 4 ? 'Visa ending in ${digits.substring(digits.length - 4)}' : 'Cash on Delivery';
      final order = await session.checkout(
        fullName: name.controller.text.trim(),
        address: address.controller.text.trim(),
        city: city.controller.text.trim(),
        paymentMethod: useCard.value ? 'Visa / Credit Card' : 'Cash on Delivery',
        pointsUsed: pointsToUse,
        cardMasked: useCard.value ? masked : 'Cash on Delivery',
      );
      Get.offNamed(AppRoutes.orderSuccess, arguments: order.id);
    } finally {
      loading.value = false;
    }
  }
}
