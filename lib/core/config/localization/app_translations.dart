import 'package:get/get.dart';
import 'package:madperfume/core/config/localization/ar_sa.dart';
import 'package:madperfume/core/config/localization/en_us.dart';
import 'package:madperfume/core/config/localization/he_il.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUs,
        'ar_SA': arSa,
        'he_IL': heIl,
      };
}
