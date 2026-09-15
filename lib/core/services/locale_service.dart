import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/constants/storage_keys.dart';
import 'package:madperfume/core/services/storage_service.dart';

class LocaleService extends GetxService {
  LocaleService(this._storage);

  final StorageService _storage;

  final locale = const Locale('en', 'US').obs;

  Future<LocaleService> init() async {
    final stored = _storage.read<String>(StorageKeys.locale);
    if (stored != null) {
      final parts = stored.split('_');
      if (parts.length == 2) {
        locale.value = Locale(parts[0], parts[1]);
      }
    }
    return this;
  }

  bool get isRtl => locale.value.languageCode == 'ar' || locale.value.languageCode == 'he';

  Future<void> updateLocale(Locale value) async {
    locale.value = value;
    await _storage.write(StorageKeys.locale, '${value.languageCode}_${value.countryCode}');
    await Get.updateLocale(value);
  }
}

ThemeData buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.light(
      primary: AppColors.ink,
      onPrimary: AppColors.surface,
      surface: AppColors.background,
      onSurface: AppColors.ink,
    ),
  );
  return base.copyWith(
    textTheme: GoogleFonts.dmSansTextTheme(base.textTheme).apply(
      bodyColor: AppColors.ink,
      displayColor: AppColors.ink,
    ),
    splashFactory: InkRipple.splashFactory,
    dividerColor: AppColors.line,
  );
}

TextStyle displayStyle({
  double size = 28,
  FontWeight weight = FontWeight.w600,
  Color color = AppColors.ink,
  double height = 1.15,
  double letterSpacing = -0.4,
}) {
  return GoogleFonts.cormorantGaramond(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );
}
