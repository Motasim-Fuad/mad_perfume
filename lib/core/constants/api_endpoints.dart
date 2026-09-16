class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://staging-api.bpmstudio.pt/api/v1';

  static const String register = '/app/auth/register/';
  static const String login = '/app/auth/login/';
  static const String refresh = '/auth/refresh/';
  static const String logout = '/auth/logout/';
  static const String passwordResetCode = '/app/auth/password-reset/code/';
  static const String passwordResetVerify = '/app/auth/password-reset/verify/';
  static const String passwordResetConfirm = '/auth/password-reset/confirm/';

  static const String me = '/app/me/';
  static const String changePassword = '/app/me/change-password/';
  static const String devices = '/app/devices/';
  static String device(String token) => '/app/devices/$token/';

  static const String categories = '/app/categories/';
  static const String banners = '/app/banners/';
  static const String products = '/app/products/';
  static String product(int id) => '/app/products/$id/';
  static String productReviews(int id) => '/app/products/$id/reviews/';
  static const String savedProducts = '/app/saved-products/';
  static String savedProduct(int id) => '/app/saved-products/$id/';

  static const String branches = '/app/branches/';
  static String branch(int id) => '/app/branches/$id/';

  static const String cart = '/app/cart/';
  static String cartItem(int id) => '/app/cart/$id/';

  static const String orders = '/app/orders/';
  static String order(int id) => '/app/orders/$id/';

  static const String loyalty = '/app/loyalty/';
  static const String loyaltyTransactions = '/app/loyalty/transactions/';
  static const String rewards = '/app/rewards/';
  static String reward(int id) => '/app/rewards/$id/';
  static String rewardRedeem(int id) => '/app/rewards/$id/redeem/';
  static const String redemptions = '/app/redemptions/';

  static const String notifications = '/app/notifications/';
  static const String notificationsUnread = '/app/notifications/unread-count/';
  static String notification(int id) => '/app/notifications/$id/';
  static const String notificationsReadAll = '/app/notifications/read-all/';
}
