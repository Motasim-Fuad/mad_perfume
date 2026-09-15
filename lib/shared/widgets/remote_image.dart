import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';

class RemoteImage extends StatelessWidget {
  const RemoteImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.label = 'perfume image here',
    this.borderRadius,
  });

  final String url;
  final BoxFit fit;
  final String label;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final fallback = ColoredBox(
      color: AppColors.surfaceMuted,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.dmSans(
              fontSize: 11,
              letterSpacing: 0.6,
              color: AppColors.muted,
            ),
          ),
        ),
      ),
    );
    final image = CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      placeholder: (context, url) => fallback,
      errorWidget: (context, url, error) => fallback,
    );
    if (borderRadius == null) {
      return image;
    }
    return ClipRRect(borderRadius: borderRadius!, child: image);
  }
}
