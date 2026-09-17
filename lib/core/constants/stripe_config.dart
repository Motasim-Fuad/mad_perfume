import 'package:flutter_dotenv/flutter_dotenv.dart';

class StripeConfig {
  StripeConfig._();

  static String get publishableKey => dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';
}