import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';

class HistoryFilterChip extends StatelessWidget {
  const HistoryFilterChip({
    super.key,
    required this.id,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String id;
  final String label;
  final bool selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8),
      child: ChoiceChip(
        selected: selected,
        label: Text(label),
        onSelected: (_) => onSelected(id),
        selectedColor: AppColors.ink,
        labelStyle: GoogleFonts.dmSans(color: selected ? Colors.white : AppColors.ink),
      ),
    );
  }
}
