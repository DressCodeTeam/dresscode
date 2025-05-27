import 'package:dresscode/src/constants/colors.dart';
import 'package:dresscode/src/models/category.model.dart';
import 'package:dresscode/src/providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryCircle extends ConsumerWidget {
  const CategoryCircle({
    required this.categoryName,
    required this.imagePath,
    this.category,
    this.backgroundColor,
    this.borderColor,
    super.key,
  });

  final Color? backgroundColor;
  final Color? borderColor;
  final String imagePath;
  final String categoryName;
  // prend la valeur 'null' quand l'utilisateur choi-
  // sit la catégorie "Tout"
  final Category? category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    final bool isSelected = (category == null) 
        ? selectedCategory == null
        : selectedCategory?.id == category!.id;

    return GestureDetector(
      onTap: () {
        // Si c'est "Tout", désélectionner toute catégorie
        if (category == null) {
          ref.read(selectedCategoryProvider.notifier).state = null;
        } else {
          // Sinon, sélectionner cette catégorie (ou la désélectionner si déjà 
          // sélectionnée)
          if (isSelected) {
            ref.read(selectedCategoryProvider.notifier).state = null;
          } else {
            ref.read(selectedCategoryProvider.notifier).state = category;
          }
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isSelected 
                  ? AppColors.secondaryColor 
                  : AppColors.disabledColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected 
                    ? AppColors.secondaryColor 
                    : AppColors.secondaryColor,
                width: isSelected ? 3 : 2,
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
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? AppColors.secondaryColor : null,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CategoriesHorizontalList extends ConsumerWidget {
  const CategoriesHorizontalList({ super.key });

  static const Map<String, String> categoryImages = {
    'Tout': 'assets/images/all-clothes.png',
    'Hauts': 'assets/images/pulls-image.png',
    'Vestes/Manteaux': 'assets/images/coat-image.webp',
    'Bas': 'assets/images/pants-image.webp',
    'Une pièce': 'assets/images/overalls-image.webp'
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return SizedBox(
      height: 100,
      child: categoriesAsync.when(
        data: (categories) => ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          children: [
            // Premier élément: "Tout"
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: CategoryCircle(
                imagePath: 'assets/images/all-clothes.png',
                categoryName: 'Tout',
              ),
            ),
            // Autres catégories de l'API
            ...categories.map((category) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CategoryCircle(
                imagePath: categoryImages[category.name] ?? 'assets/images/default-icon.png',
                categoryName: category.name,
                category: category,
              ),
            )),
          ],
        ),
        loading: () => null,
        error: (_, __) => ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: CategoryCircle(
                imagePath: 'assets/images/all-clothes.png',
                categoryName: 'Tout',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
