import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/shared/widgets/money_text.dart';

class AmountRow extends StatelessWidget {
  const AmountRow({
    super.key,
    required this.label,
    required this.value,
    this.free = false,
    this.bold = false,
    this.freeLabel,
  });

  final String label;
  final double value;
  final bool free;
  final bool bold;
  final String? freeLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.dmSans(fontWeight: bold ? FontWeight.w800 : FontWeight.w500),
            ),
          ),
          if (free)
            Text(freeLabel ?? '')
          else
            MoneyText(value, size: 14, weight: bold ? FontWeight.w800 : FontWeight.w600),
        ],
      ),
    );
  }
}
