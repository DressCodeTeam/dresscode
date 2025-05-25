import 'package:dresscode/src/constants/colors.dart';
import 'package:dresscode/src/hooks/use_side_effect.dart';
import 'package:dresscode/src/models/garment.model.dart';
import 'package:dresscode/src/providers/garment_providers.dart';
import 'package:dresscode/src/widgets/category_button.dart';
import 'package:dresscode/src/widgets/garment_card.dart';
import 'package:dresscode/src/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClosetPage extends HookConsumerWidget {
  const ClosetPage({ super.key });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final garmentEffect = useSideEffect<Garment>();
    final garmentService = ref.watch(garmentServiceProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            // Profile
            const ProfileStatsCard(
              userName: 'John Doe',
              totalClothes: 3,
              totalOutfits: 1,
            ),
            const SizedBox(height: 16),

            // Categories horizontally scrollable
            SizedBox(
              height: 90,
              child: ListView(
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: CategoryCircle(
                      imagePath: 'assets/images/pulls-icon.png',
                      categoryName: 'Hauts',
                    ),
                  ),
                ],
              ),
            ),

            // Display garmentEffect status
            garmentEffect.snapshot.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              // TODO(aman): replace by error page or dialog
              error: (error, stack) => Text('Erreur: $error'), 
              data: (garment) => garment != null 
                  ? const Text('Vêtement enregistré !') 
                  : const SizedBox.shrink(),
            ),
        
            // Display garments list
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final garmentsAsync = ref.watch(garmentsProvider);

                  return garmentsAsync.when(
                    loading: () => const Center(
                      child: CircularProgressIndicator()
                    ),
                    error: (error, _) => Center(child: Text('Error: $error')),
                    data: (garments) => GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 4,
                      ),
                      itemCount: garments.length,
                      itemBuilder: (context, index) {
                        final garment = garments[index];
                        return GarmentCard(imageUrl: garment.imageUrl);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
