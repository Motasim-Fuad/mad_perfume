import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static void info(String message) {
    if (kDebugMode) {
      debugPrint('[MAD] $message');
    }
  }

  static void error(String message, [Object? error]) {
    if (kDebugMode) {
      debugPrint('[MAD][ERR] $message ${error ?? ''}');
    }
  }
}
