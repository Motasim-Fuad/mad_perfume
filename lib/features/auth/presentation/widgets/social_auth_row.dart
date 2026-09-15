import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madperfume/features/auth/presentation/widgets/social_auth_chip.dart';

class SocialAuthRow extends StatelessWidget {
  const SocialAuthRow({super.key, required this.onGoogle, required this.onApple});

  final VoidCallback onGoogle;
  final VoidCallback onApple;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SocialAuthChip(label: 'google'.tr, onTap: onGoogle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SocialAuthChip(label: 'apple'.tr, onTap: onApple, dark: true),
        ),
      ],
    );
  }
}
