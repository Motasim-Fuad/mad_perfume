import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/di/locator.dart';
import 'package:madperfume/core/utils/route_args.dart';
import 'package:madperfume/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:madperfume/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:madperfume/features/auth/presentation/pages/login_page.dart';
import 'package:madperfume/features/auth/presentation/pages/register_page.dart';
import 'package:madperfume/features/auth/presentation/pages/reset_password_page.dart';
import 'package:madperfume/features/auth/presentation/pages/splash_page.dart';
import 'package:madperfume/features/auth/presentation/pages/welcome_page.dart';
import 'package:madperfume/features/branches/presentation/pages/branch_details_page.dart';
import 'package:madperfume/features/branches/presentation/pages/branches_page.dart';
import 'package:madperfume/features/cart/presentation/pages/checkout_page.dart';
import 'package:madperfume/features/catalog/presentation/cubit/catalog_cubits.dart';
import 'package:madperfume/features/commerce/presentation/cubit/checkout_cubit.dart';
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
import 'package:madperfume/features/loyalty/presentation/cubit/loyalty_cubits.dart';
import 'package:madperfume/features/profile/presentation/cubit/profile_cubits.dart';
import 'package:madperfume/features/products/presentation/pages/product_details_page.dart';
import 'package:madperfume/features/products/presentation/pages/product_list_page.dart';
import 'package:madperfume/features/profile/presentation/pages/all_orders_page.dart';
import 'package:madperfume/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:madperfume/features/profile/presentation/pages/notification_settings_page.dart';
import 'package:madperfume/features/profile/presentation/pages/saved_items_page.dart';
import 'package:madperfume/features/profile/presentation/pages/security_page.dart';
import 'package:madperfume/features/profile/presentation/pages/settings_page.dart';
import 'package:madperfume/features/shell/presentation/pages/main_shell_page.dart';

class AppPages {
  AppPages._();

  static final pages = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.splash,
      page: SplashPage.new,
      transition: Transition.fade,
    ),
    GetPage(name: AppRoutes.welcome, page: WelcomePage.new),
    GetPage(name: AppRoutes.login, page: () => _authPage(const LoginPage())),
    GetPage(
      name: AppRoutes.register,
      page: () => _authPage(const RegisterPage()),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => _authPage(const ForgotPasswordPage()),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => _authPage(const ResetPasswordPage()),
    ),
    GetPage(
      name: AppRoutes.main,
      page: MainShellPage.new,
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => BlocProvider(
        create: (_) => sl<SearchCubit>(),
        child: const SearchPage(),
      ),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => BlocProvider(
        create: (_) => sl<NotificationsCubit>()..load(),
        child: const NotificationsPage(),
      ),
    ),
    GetPage(
      name: AppRoutes.productList,
      page: () => BlocProvider(
        create: (_) => sl<ProductListCubit>(param1: routeId())..load(),
        child: const ProductListPage(),
      ),
    ),
    GetPage(
      name: AppRoutes.productDetails,
      page: () => BlocProvider(
        create: (_) => sl<ProductDetailsCubit>(param1: routeId())..load(),
        child: const ProductDetailsPage(),
      ),
    ),
    GetPage(
      name: AppRoutes.checkout,
      page: () => BlocProvider(
        create: (_) => sl<CheckoutCubit>(),
        child: const CheckoutPage(),
      ),
    ),
    GetPage(
      name: AppRoutes.orderSuccess,
      page: () => BlocProvider(
        create: (_) => sl<OrderDetailCubit>(param1: routeId())..load(),
        child: const OrderSuccessPage(),
      ),
    ),
    GetPage(
      name: AppRoutes.orderTracking,
      page: () => BlocProvider(
        create: (_) => sl<OrderDetailCubit>(param1: routeId())..load(),
        child: const OrderTrackingPage(),
      ),
    ),
    GetPage(
      name: AppRoutes.orderDetails,
      page: () => BlocProvider(
        create: (_) => sl<OrderDetailCubit>(param1: routeId())..load(),
        child: const OrderDetailsPage(),
      ),
    ),
    GetPage(
      name: AppRoutes.writeReview,
      page: () => BlocProvider(
        create: (_) => sl<WriteReviewCubit>(param1: routeId('productId')),
        child: const WriteReviewPage(),
      ),
    ),
    GetPage(name: AppRoutes.earnPoints, page: EarnPointsPage.new),
    GetPage(
      name: AppRoutes.rewards,
      page: () => BlocProvider(
        create: (_) => sl<RewardsCubit>()..load(),
        child: const RewardsPage(),
      ),
    ),
    GetPage(
      name: AppRoutes.rewardDetails,
      page: () => BlocProvider(
        create: (_) => sl<RewardDetailCubit>(param1: routeId())..load(),
        child: const RewardDetailsPage(),
      ),
    ),
    GetPage(
      name: AppRoutes.redeemedRewards,
      page: () => BlocProvider(
        create: (_) => sl<RedemptionsCubit>()..load(),
        child: const RedeemedRewardsPage(),
      ),
    ),
    GetPage(
      name: AppRoutes.pointsHistory,
      page: () => BlocProvider(
        create: (_) => sl<HistoryCubit>()..load(),
        child: const PointsHistoryPage(),
      ),
    ),
    GetPage(name: AppRoutes.settings, page: SettingsPage.new),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => BlocProvider(
        create: (_) => sl<EditProfileCubit>(),
        child: const EditProfilePage(),
      ),
    ),
    GetPage(
      name: AppRoutes.security,
      page: () => BlocProvider(
        create: (_) => sl<SecurityCubit>(),
        child: const SecurityPage(),
      ),
    ),
    GetPage(
      name: AppRoutes.notificationSettings,
      page: () => BlocProvider(
        create: (_) => sl<PrefsCubit>(),
        child: const NotificationSettingsPage(),
      ),
    ),
    GetPage(
      name: AppRoutes.savedItems,
      page: () => BlocProvider(
        create: (_) => sl<SavedCubit>()..load(),
        child: const SavedItemsPage(),
      ),
    ),
    GetPage(
      name: AppRoutes.allOrders,
      page: () => BlocProvider(
        create: (_) => sl<OrdersCubit>()..load(),
        child: const AllOrdersPage(),
      ),
    ),
    GetPage(
      name: AppRoutes.branches,
      page: () => BlocProvider(
        create: (_) => sl<BranchesCubit>()..search(''),
        child: const BranchesPage(),
      ),
    ),
    GetPage(
      name: AppRoutes.branchDetails,
      page: () => BlocProvider(
        create: (_) => sl<BranchDetailCubit>(param1: routeId())..load(),
        child: const BranchDetailsPage(),
      ),
    ),
  ];
}

Widget _authPage(Widget child) {
  sl<AuthCubit>().clearError();
  return child;
}
