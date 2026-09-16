import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/models/catalog_models.dart';
import 'package:madperfume/features/profile/presentation/cubit/profile_cubits.dart';
import 'package:madperfume/features/branches/presentation/widgets/branch_info_block.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';
import 'package:madperfume/shared/widgets/query_body.dart';

class BranchDetailsPage extends StatelessWidget {
  const BranchDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<BranchDetailCubit>();
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child:
          BlocBuilder<
            BranchDetailCubit,
            ({BranchModel? branch, bool loading, String error})
          >(
            builder: (context, state) => QueryBody(
              loading: state.loading,
              error: state.error,
              onRetry: controller.load,
              onRefresh: controller.load,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                children: [
                  if (state.branch case final branch?) ...[
                    Text(
                      'branch_details'.tr,
                      style: GoogleFonts.dmSans(
                        letterSpacing: 2,
                        fontSize: 11,
                        color: AppColors.muted,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: AspectRatio(
                        aspectRatio: 1.2,
                        child: RemoteImage(
                          url: branch.imageUrl,
                          label: 'boutique image here',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'flagship_boutique'.tr,
                      style: GoogleFonts.dmSans(
                        letterSpacing: 1.6,
                        fontSize: 11,
                        color: AppColors.muted,
                      ),
                    ),
                    Text(
                      branch.name.toUpperCase(),
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    BranchInfoBlock(title: 'address'.tr, body: branch.address),
                    BranchInfoBlock(
                      title: 'contact'.tr,
                      body: '${branch.phone}\n${branch.email}',
                    ),
                    BranchInfoBlock(title: 'hours'.tr, body: branch.hours),
                  ],
                ],
              ),
            ),
          ),
    );
  }
}
