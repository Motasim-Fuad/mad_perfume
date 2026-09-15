import 'package:get/get.dart';
import 'package:madperfume/config/bindings/feature_bindings.dart';
import 'package:madperfume/config/bindings/theme/theme_binding.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/features/auth/presentation/bindings/auth_binding.dart';
import 'package:madperfume/features/auth/presentation/bindings/splash_binding.dart';
import 'package:madperfume/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:madperfume/features/auth/presentation/pages/login_page.dart';
import 'package:madperfume/features/auth/presentation/pages/register_page.dart';
import 'package:madperfume/features/auth/presentation/pages/reset_password_page.dart';
import 'package:madperfume/features/auth/presentation/pages/splash_page.dart';
import 'package:madperfume/features/auth/presentation/pages/welcome_page.dart';
import 'package:madperfume/features/branches/presentation/pages/branch_details_page.dart';
import 'package:madperfume/features/branches/presentation/pages/branches_page.dart';
import 'package:madperfume/features/cart/presentation/pages/checkout_page.dart';
import 'package:madperfume/features/home/presentation/bindings/product_search_binding.dart';
import 'package:madperfume/features/home/presentation/pages/search_page.dart';
import 'package:madperfume/features/loyalty/presentation/pages/earn_points_page.dart';
import 'package:madperfume/features/loyalty/presentation/pages/points_history_page.dart';
import 'package:madperfume/features/loyalty/presentation/pages/redeemed_rewards_page.dart';
import 'package:madperfume/features/loyalty/presentation/pages/reward_details_page.dart';
import 'package:madperfume/features/loyalty/presentation/pages/rewards_page.dart';
import 'package:madperfume/features/notifications/presentation/pages/notifications_page.dart';
import 'package:madperfume/features/orders/presentation/pages/order_details_page.dart';
import 'package:madperfume/features/orders/presentation/pages/order_success_page.dart';
import 'package:madperfume/features/orders/presentation/pages/order_tracking_page.dart';
import 'package:madperfume/features/orders/presentation/pages/write_review_page.dart';
import 'package:madperfume/features/products/presentation/bindings/product_details_binding.dart';
import 'package:madperfume/features/products/presentation/bindings/product_list_binding.dart';
import 'package:madperfume/features/products/presentation/pages/product_details_page.dart';
import 'package:madperfume/features/products/presentation/pages/product_list_page.dart';
import 'package:madperfume/features/profile/presentation/pages/all_orders_page.dart';
import 'package:madperfume/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:madperfume/features/profile/presentation/pages/notification_settings_page.dart';
import 'package:madperfume/features/profile/presentation/pages/saved_items_page.dart';
import 'package:madperfume/features/profile/presentation/pages/security_page.dart';
import 'package:madperfume/features/profile/presentation/pages/settings_page.dart';
import 'package:madperfume/features/shell/presentation/bindings/shell_binding.dart';
import 'package:madperfume/features/shell/presentation/pages/main_shell_page.dart';

class AppPages {
  AppPages._();

  static final pages = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.splash,
      page: SplashPage.new,
      binding: SplashBinding(),
      transition: Transition.fade,
    ),
    GetPage(name: AppRoutes.welcome, page: WelcomePage.new, binding: ThemeBinding()),
    GetPage(name: AppRoutes.login, page: LoginPage.new, binding: AuthBinding()),
    GetPage(name: AppRoutes.register, page: RegisterPage.new, binding: AuthBinding()),
    GetPage(name: AppRoutes.forgotPassword, page: ForgotPasswordPage.new, binding: AuthBinding()),
    GetPage(name: AppRoutes.resetPassword, page: ResetPasswordPage.new, binding: AuthBinding()),
    GetPage(
      name: AppRoutes.main,
      page: MainShellPage.new,
      binding: ShellBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.search,
      page: SearchPage.new,
      binding: ProductSearchBinding(),
    ),
    GetPage(name: AppRoutes.notifications, page: NotificationsPage.new, binding: NotificationsBinding()),
    GetPage(name: AppRoutes.productList, page: ProductListPage.new, binding: ProductListBinding()),
    GetPage(name: AppRoutes.productDetails, page: ProductDetailsPage.new, binding: ProductDetailsBinding()),
    GetPage(name: AppRoutes.checkout, page: CheckoutPage.new, binding: CheckoutBinding()),
    GetPage(name: AppRoutes.orderSuccess, page: OrderSuccessPage.new, binding: OrderFlowBinding()),
    GetPage(name: AppRoutes.orderTracking, page: OrderTrackingPage.new),
    GetPage(name: AppRoutes.orderDetails, page: OrderDetailsPage.new, binding: OrderFlowBinding()),
    GetPage(name: AppRoutes.writeReview, page: WriteReviewPage.new, binding: WriteReviewBinding()),
    GetPage(name: AppRoutes.earnPoints, page: EarnPointsPage.new),
    GetPage(name: AppRoutes.rewards, page: RewardsPage.new, binding: LoyaltyExtraBinding()),
    GetPage(name: AppRoutes.rewardDetails, page: RewardDetailsPage.new, binding: RewardDetailsBinding()),
    GetPage(name: AppRoutes.redeemedRewards, page: RedeemedRewardsPage.new),
    GetPage(name: AppRoutes.pointsHistory, page: PointsHistoryPage.new, binding: LoyaltyExtraBinding()),
    GetPage(name: AppRoutes.settings, page: SettingsPage.new, binding: SettingsBinding()),
    GetPage(name: AppRoutes.editProfile, page: EditProfilePage.new, binding: EditProfileBinding()),
    GetPage(name: AppRoutes.security, page: SecurityPage.new, binding: SecurityBinding()),
    GetPage(name: AppRoutes.notificationSettings, page: NotificationSettingsPage.new, binding: NotificationSettingsBinding()),
    GetPage(name: AppRoutes.savedItems, page: SavedItemsPage.new),
    GetPage(name: AppRoutes.allOrders, page: AllOrdersPage.new),
    GetPage(name: AppRoutes.branches, page: BranchesPage.new, binding: BranchesBinding()),
    GetPage(name: AppRoutes.branchDetails, page: BranchDetailsPage.new, binding: BranchDetailsBinding()),
  ];
}
