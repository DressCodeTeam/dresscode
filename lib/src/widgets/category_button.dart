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

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    required this.selectedCategory,
    required this.onCategoryChanged,
    super.key,
  });

  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  static const List<String> categories = [
    'Hauts',
    'Bas',
    'Hiver',
    'Pulls',
    'Pantalons',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Catégorie:',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = category == selectedCategory;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => onCategoryChanged(category),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.secondaryColor
                          : Colors.transparent,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.secondaryColor
                            : Colors.white.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
