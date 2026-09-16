import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/services/locale_service.dart';

class MoneyText extends StatelessWidget {
  const MoneyText(
    this.value, {
    super.key,
    this.size = 16,
    this.weight = FontWeight.w700,
  });

  final double value;
  final double size;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    final rtl = Get.find<LocaleService>().isRtl;
    final amount = value.toStringAsFixed(2);
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 2),
      child: Text(
        rtl ? '$amount \$' : '\$$amount',
        maxLines: 1,
        overflow: TextOverflow.visible,
        style: GoogleFonts.dmSans(
          fontSize: size,
          fontWeight: weight,
          color: AppColors.ink,
        ),
      ),
    );
  }
}
