import 'package:cached_network_image/cached_network_image.dart';
import 'package:dresscode/src/shared/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

class OutfitsCard extends StatelessWidget {
  const OutfitsCard({
    this.onTap,
    super.key
  });
  
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: context.screenWidth * 0.35,
        height: context.screenHeight * 0.4,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          elevation: 2,
          clipBehavior: Clip.antiAlias,
          shadowColor: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: GridView.count(
              crossAxisCount: 3, // 3 colonnes
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              children: List.generate(9, (index) {
                return CachedNetworkImage(
                  imageUrl: 'https://picsum.photos/id/${index + 30}/100',
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
