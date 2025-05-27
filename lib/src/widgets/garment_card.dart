import 'package:cached_network_image/cached_network_image.dart';
import 'package:dresscode/src/constants/colors.dart';
import 'package:dresscode/src/shared/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

class GarmentCard extends StatelessWidget {
  const GarmentCard({
    required this.imageUrl
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: 180,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.contain
        ),
      ),
    );
  }
}
