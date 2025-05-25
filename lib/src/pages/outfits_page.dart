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
          'Mes outfits',
          style: TextStyle(color: Colors.white)
        ),
        backgroundColor: AppColors.primaryColor.withAlpha(200),
      ),
      body: outfitsAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Erreur : $error'),
        ),
        data: (outfits) {
          if (outfits.isEmpty) {
            return const Center(
              child: Text('Aucun outfit créé pour le moment'),
            );
          }
          
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.7, // Ajustez ce ratio selon vos besoins
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
                  style: outfit.style, // Ajout du style de l'outfit
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OutfitDetailPage(
                          imageUrls: imageUrls,
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
    );
  }
}
