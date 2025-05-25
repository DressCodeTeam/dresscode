import 'package:cached_network_image/cached_network_image.dart';
import 'package:dresscode/src/shared/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

class GarmentCard extends StatelessWidget {
  const GarmentCard({
    required this.imageUrl
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth * 0.35,
      height: context.screenHeight * 0.4,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.grey,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.fill
        ),
      ),
    );
  }
}
