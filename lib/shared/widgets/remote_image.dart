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

  static const _headers = {
    'Accept': 'image/avif,image/webp,image/apng,image/*,*/*;q=0.8',
    'User-Agent':
        'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1',
  };

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
      httpHeaders: _headers,
      fadeInDuration: const Duration(milliseconds: 180),
      placeholder: (context, url) => const ColoredBox(
        color: AppColors.surfaceMuted,
        child: Center(
          child: SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 1.6,
              color: AppColors.muted,
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => fallback,
    );
    if (borderRadius == null) {
      return image;
    }
    return ClipRRect(borderRadius: borderRadius!, child: image);
  }
}
