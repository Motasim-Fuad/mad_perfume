import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/core/services/session_store.dart';
import 'package:madperfume/features/shell/presentation/controllers/shell_controller.dart';
import 'package:madperfume/shared/widgets/language_selector_widget.dart';

class HomeController extends GetxController {
  final query = ''.obs;

  SessionStore get session => Get.find<SessionStore>();

  String get firstName {
    final name = session.user.value?.fullName ?? 'Beautiful';
    final parts = name.trim().split(' ');
    return parts.first;
  }

  List<ProductEntity> get featured => CatalogData.featured();

  List<CollectionEntity> get collections => CatalogData.collections;

  List<BranchEntity> get boutiques => CatalogData.branches.take(2).toList();

  void openNotifications() => Get.toNamed(AppRoutes.notifications);

  void openLanguage() => openLanguageSheet();

  void openCollection(String id) => Get.toNamed(AppRoutes.productList, arguments: id);

  void openAllCollections() => Get.find<ShellController>().setTab(1);

  void openProduct(String id) => Get.toNamed(AppRoutes.productDetails, arguments: id);

  void openBranches() => Get.toNamed(AppRoutes.branches);

  void openBranch(String id) => Get.toNamed(AppRoutes.branchDetails, arguments: id);

  List<ProductEntity> search() {
    final q = query.value.trim().toLowerCase();
    if (q.isEmpty) {
      return const [];
    }
    return CatalogData.products
        .where((item) => item.name.toLowerCase().contains(q) || item.tags.join().toLowerCase().contains(q))
        .toList();
  }
}
