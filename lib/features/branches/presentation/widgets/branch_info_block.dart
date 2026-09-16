import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';

class BranchInfoBlock extends StatelessWidget {
  const BranchInfoBlock({super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
          Text(
            body,
            style: GoogleFonts.dmSans(height: 1.45, color: AppColors.inkSoft),
          ),
        ],
      ),
    );
  }
}
