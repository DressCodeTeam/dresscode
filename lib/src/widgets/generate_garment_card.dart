import 'package:cached_network_image/cached_network_image.dart';
import 'package:dresscode/src/constants/colors.dart';
import 'package:flutter/material.dart';

class GGarmentCard extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const GGarmentCard({
    required this.imageUrl,
    this.width = 180,
    this.height = 210,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.disabledColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.secondaryColor.withOpacity(0.2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}