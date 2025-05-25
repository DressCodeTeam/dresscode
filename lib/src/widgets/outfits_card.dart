import 'package:cached_network_image/cached_network_image.dart';
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
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0, // Espace en haut
                  left: 8.0, // Espace à gauche
                  right: 8.0, // Espace à droite
                  bottom: 8.0, // Espace en bas
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
              style: TextStyle(
                color: Colors.grey.shade700,
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
