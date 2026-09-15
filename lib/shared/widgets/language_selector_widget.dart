import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/constants/app_sizes.dart';
import 'package:madperfume/core/services/locale_service.dart';
import 'package:madperfume/shared/widgets/language_tile.dart';

class LanguageSelectorWidget extends StatelessWidget {
  const LanguageSelectorWidget({
    super.key,
    required this.selected,
    required this.onSelect,
    required this.onApply,
  });

  final Locale selected;
  final ValueChanged<Locale> onSelect;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 14, 22, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.line,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'select_language'.tr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: Get.back,
                  icon: const Icon(Icons.close, color: AppColors.ink),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LanguageTile(
              title: 'العربية',
              subtitle: 'arabic'.tr,
              locale: const Locale('ar', 'SA'),
              selected: selected,
              onSelect: onSelect,
            ),
            LanguageTile(
              title: 'עברית',
              subtitle: 'hebrew'.tr,
              locale: const Locale('he', 'IL'),
              selected: selected,
              onSelect: onSelect,
            ),
            LanguageTile(
              title: 'English',
              subtitle: 'united_kingdom'.tr,
              locale: const Locale('en', 'US'),
              selected: selected,
              onSelect: onSelect,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: AppSizes.buttonHeight,
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.ink,
                  foregroundColor: AppColors.surface,
                  shape: const StadiumBorder(),
                ),
                onPressed: onApply,
                child: FittedBox(
                  child: Text(
                    'apply_changes'.tr,
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> openLanguageSheet() {
  final service = Get.find<LocaleService>();
  final draft = service.locale.value.obs;
  return Get.bottomSheet(
    Obx(
      () => LanguageSelectorWidget(
        selected: draft.value,
        onSelect: (value) => draft.value = value,
        onApply: () async {
          await service.updateLocale(draft.value);
          Get.back();
        },
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}
