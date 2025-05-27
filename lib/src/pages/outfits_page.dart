import 'package:dresscode/src/constants/colors.dart';
import 'package:dresscode/src/pages/outfit_detail.dart';
import 'package:dresscode/src/providers/outfit_providers.dart';
import 'package:dresscode/src/widgets/outfits_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OutfitsPage extends ConsumerWidget {
  const OutfitsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outfitsAsyncValue = ref.watch(outfitsProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Mes Outfits',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        color: AppColors.disabledColor.withOpacity(0.2), // Fond subtil
        child: outfitsAsyncValue.when(
          loading: () => Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              'Une erreur est survenue',
              style: TextStyle(color: AppColors.textColor),
            ),
          ),
          data: (outfits) {
            if (outfits.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warehouse,
                      size: 48,
                      color: AppColors.secondaryColor.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Aucun outfit créé pour le moment',
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Commencez par créer votre premier outfit',
                      style: TextStyle(
                        color: AppColors.textColor.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            }
            
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: outfits.length,
                itemBuilder: (context, index) {
                  final outfit = outfits[index];
                  final imageUrls = outfit.garments
                      .map((g) => g.imageUrl)
                      .where((url) => url.isNotEmpty)
                      .toList();
                  
                  return OutfitsCard(
                    imageUrls: imageUrls,
                    style: outfit.style,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OutfitDetailPage(
                            imageUrls: imageUrls,
                            style: outfit.style,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}