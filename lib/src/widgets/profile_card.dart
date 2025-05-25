// Widget stateless pour les statistiques du profil
import 'package:dresscode/src/constants/colors.dart';
import 'package:flutter/material.dart';

class ProfileStatsCard extends StatelessWidget {
  const ProfileStatsCard({
    required this.userName,
    required this.totalClothes,
    required this.totalOutfits,
    this.profileImageUrl,
    super.key,
  });

  final String? profileImageUrl;
  final String userName;
  final int totalClothes;
  final int totalOutfits;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // card container
        Container(
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.only(
            top: 40,
            bottom: 16,
            left: 20,
            right: 20
          ),
          decoration: BoxDecoration(
            color: AppColors.disabledColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(25),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // Nom d'utilisateur
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              
              // Statistiques
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem(
                    icon: Icons.checkroom,
                    count: totalClothes,
                    label: 'Vêtements',
                  ),
                  _buildStatItem(
                    icon: Icons.palette,
                    count: totalOutfits,
                    label: 'Outfits',
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Overlapping profile picture
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: profileImageUrl != null
                  ? Image.network(profileImageUrl!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 80,
                          height: 80,
                          color: AppColors.primaryColor.withOpacity(0.2),
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: AppColors.primaryColor,
                          ),
                        );
                      },
                    )
                  : Container(
                      width: 80,
                      height: 80,
                      color: AppColors.primaryColor.withAlpha(45),
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: AppColors.primaryColor,
                      ),
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required int count,
    required String label,
  }) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
