import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/features/profile/presentation/cubit/profile_cubits.dart';
import 'package:madperfume/shared/widgets/app_field.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class WriteReviewPage extends StatelessWidget {
  const WriteReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<WriteReviewCubit>();
    return ScreenScaffold(
      header: const BrandHeader(showBack: true),
      child: ListView(
        children: [
          Text(
            'write_a_review'.tr,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          BlocBuilder<
            WriteReviewCubit,
            ({int rating, bool loading, String error})
          >(
            builder: (context, state) => Row(
              children: List.generate(
                5,
                (index) => IconButton(
                  onPressed: () => controller.setRating(index + 1),
                  icon: Icon(
                    index < state.rating ? Icons.star : Icons.star_border,
                  ),
                ),
              ),
            ),
          ),
          AppField(
            controller: controller.body,
            label: 'share_thoughts'.tr,
            hint: 'review_hint'.tr,
            maxLines: 5,
          ),
          const SizedBox(height: 20),
          BlocBuilder<
            WriteReviewCubit,
            ({int rating, bool loading, String error})
          >(
            builder: (context, state) => AppButton(
              label: 'publish_review'.tr,
              loading: state.loading,
              error: state.error,
              onPressed: controller.submit,
            ),
          ),
        ],
      ),
    );
  }
}
