import 'package:get/get.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/core/services/session_store.dart';
import 'package:madperfume/features/shell/presentation/controllers/shell_controller.dart';

class ProductDetailsController extends GetxController {
  ProductDetailsController(this.product);

  final ProductEntity product;

  SessionStore get session => Get.find<SessionStore>();

  bool get saved => session.wishlist.contains(product.id);

  Future<void> toggleSaved() => session.toggleSaved(product.id);

  Future<void> addToCart() async {
    await session.addToCart(
      ProductEntityRef(
        productId: product.id,
        name: product.name,
        volume: product.volume,
        imageUrl: product.imageUrl,
        price: product.price,
        collectionId: product.collectionId,
      ),
    );
    await ShellController.returnToMain(tab: 2);
  }
}
