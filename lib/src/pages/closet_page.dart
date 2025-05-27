import 'package:dresscode/src/providers/categories_provider.dart';
import 'package:dresscode/src/providers/garment_providers.dart';
import 'package:dresscode/src/widgets/category_buttons.dart';
import 'package:dresscode/src/widgets/garment_card.dart';
import 'package:dresscode/src/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClosetPage extends HookConsumerWidget {
  const ClosetPage({ super.key });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            // Profil
            const ProfileStatsCard(
              userName: 'John Doe',
              totalClothes: 3,
              totalOutfits: 1,
            ),
            const SizedBox(height: 16),

            // Liste des catégories
            const CategoriesHorizontalList(),

            // Vêtements enregistrés
            Consumer(
              builder: (context, ref, child) {
                final garmentsAsync = ref.watch(filteredGarmentsProvider);

                return garmentsAsync.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator()
                  ),
                  error: (error, _) => Center(child: Text('Error: $error')),
                  data: (garments) => Expanded( // Ajoute Expanded ici
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 12,
                        childAspectRatio: 180 / 210, // Ratio de ton GarmentCard (largeur/hauteur)
                      ),
                      itemCount: garments.length,
                      itemBuilder: (context, index) {
                        final garment = garments[index];
                        return GarmentCard(imageUrl: garment.imageUrl);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
