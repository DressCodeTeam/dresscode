import 'package:dresscode/src/constants/colors.dart';
import 'package:dresscode/src/pages/camera_page.dart';
import 'package:dresscode/src/pages/closet_page.dart';
import 'package:dresscode/src/pages/create_outfits.dart';
import 'package:dresscode/src/pages/outfits_page.dart';
import 'package:dresscode/src/providers/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);
    final pages = [
      const ClosetPage(),
      const OutfitsPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Pages en plein écran
          pages[indexBottomNavbar],
          
          // Navigation flottante pour récupérer un peu d'espace
          // en bas de l'écran.
          Positioned(
            bottom: 16,
            left: 120,
            right: 120,
            child: SafeArea(
              child: Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withAlpha(180),
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withAlpha(100),
                      offset: const Offset(0, 20),
                      blurRadius: 20
                    )
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => ref.read(indexBottomNavbarProvider.notifier)
                                          .state = 0,
                      icon: const Icon(Icons.door_sliding),
                      iconSize: 30,
                      tooltip: 'Garde-robe',
                      color: indexBottomNavbar == 0
                        ? AppColors.secondaryColor
                        : AppColors.disabledColor,
                    ),
                    IconButton(
                      onPressed: () => ref.read(indexBottomNavbarProvider.notifier)
                                          .state = 1,
                      icon: const Icon(Icons.checkroom),
                      tooltip: 'Outfits',
                      color: indexBottomNavbar == 1
                        ? AppColors.secondaryColor
                        : Colors.white,
                      iconSize: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ClipOval(
        child: Material(
          color: AppColors.primaryColor.withAlpha(180),
          elevation: 10,
          child: InkWell(
            child: const SizedBox(
              width: 56,
              height: 56,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
            onTap: () {
              if (indexBottomNavbar == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateOutfitPage(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraPage(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
