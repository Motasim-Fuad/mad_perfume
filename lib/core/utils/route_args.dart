import 'package:get/get.dart';

int routeId([String key = 'id']) {
  final args = Get.arguments;
  if (args is int) {
    return args;
  }
  if (args is String) {
    return int.tryParse(args) ?? 0;
  }
  if (args is Map) {
    final value =
        args[key] ?? args['id'] ?? args['productId'] ?? args['orderId'];
    if (value is int) {
      return value;
    }
    return int.tryParse('$value') ?? 0;
  }
  return 0;
}
