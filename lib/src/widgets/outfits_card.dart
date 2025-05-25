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
            width: context.screenWidth * 0.5,
            height: context.screenWidth * 0.5,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              elevation: 3,
              clipBehavior: Clip.antiAlias,
              shadowColor: const Color(0xFFD8C3A5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 8.0,
                  right: 8.0,
                  bottom: 8.0,
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  children: imageUrls.take(4).map((imageUrl) {
                    return CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          // Texte en dehors de la card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              style,
              style: const TextStyle(
                color: AppColors.textColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
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
