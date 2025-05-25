import 'package:dresscode/src/constants/colors.dart';
import 'package:flutter/material.dart';

class CategoryCircle extends StatelessWidget {
  const CategoryCircle({
    required this.categoryName,
    required this.imagePath,
    this.backgroundColor,
    this.borderColor,
    super.key,
  });

  final Color? backgroundColor;
  final Color? borderColor;
  final String imagePath;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.disabledColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor ?? AppColors.secondaryColor,
              width: 2,
            ),
          ),
          child: Image.asset(
            imagePath,
            width: 100,
            height: 100,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          categoryName,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
