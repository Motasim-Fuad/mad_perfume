import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: GoogleFonts.dmSans(fontSize: 15, color: AppColors.muted, height: 1.4),
        ),
      ),
    );
  }
}
