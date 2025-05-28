import 'package:cached_network_image/cached_network_image.dart';
import 'package:dresscode/src/constants/colors.dart';
import 'package:dresscode/src/shared/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

class OutfitsCard extends StatelessWidget {
  const OutfitsCard({
    required this.imageUrls,
    required this.style,
    this.onTap,
    super.key,
  });

  final List<String> imageUrls;
  final String style;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Card avec les images
          SizedBox(
            width: context.screenWidth * 0.45,
            height: context.screenWidth * 0.45,
            child: Card(
              // surfaceTintColor: Colors.transparent,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              elevation: 2,
              clipBehavior: Clip.antiAlias,
              shadowColor: AppColors.secondaryColor.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: AppColors.disabledColor.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  children: imageUrls.take(4).map((imageUrl) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.disabledColor,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Texte en dehors de la card
          SizedBox(
            width: context.screenWidth * 0.4,
            child: Text(
              style,
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}