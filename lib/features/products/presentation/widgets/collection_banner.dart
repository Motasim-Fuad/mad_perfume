import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';

class CollectionBanner extends StatelessWidget {
  const CollectionBanner({super.key, required this.collection, required this.onTap});

  final CollectionEntity collection;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: SizedBox(
          height: 168,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              RemoteImage(url: collection.imageUrl, label: 'collection image here'),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.1),
                      Colors.black.withValues(alpha: 0.55),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'olfactive_family'.tr,
                        style: GoogleFonts.dmSans(
                          color: Colors.white70,
                          fontSize: 10,
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        collection.heroLabel,
                        style: GoogleFonts.cormorantGaramond(
                          color: Colors.white,
                          fontSize: 28,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
