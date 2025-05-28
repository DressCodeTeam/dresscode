import 'package:dresscode/src/constants/colors.dart';
import 'package:dresscode/src/models/garment.model.dart';
import 'package:dresscode/src/models/outfit.model.dart';
import 'package:dresscode/src/providers/outfit_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenerateOutfitsResultsPage extends ConsumerStatefulWidget {
  final int styleId;
  final String styleName;
  final String weather;
  final int nbOutfits;

  const GenerateOutfitsResultsPage({
    super.key,
    required this.styleId,
    required this.styleName,
    required this.weather,
    required this.nbOutfits,
  });

  @override
  ConsumerState<GenerateOutfitsResultsPage> createState() =>
      _GenerateOutfitsResultsPageState();
}

class _GenerateOutfitsResultsPageState
    extends ConsumerState<GenerateOutfitsResultsPage> {
  Map<String, dynamic> get _generateParams => {
        'nb_outfits': widget.nbOutfits,
        'style_id': widget.styleId,
        'weather': widget.weather,
      };

  @override
  Widget build(BuildContext context) {
    final outfitsAsync = ref.watch(generateOutfitsProvider(_generateParams));

    print('État du provider : $outfitsAsync');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Outfits Générés'),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(generateOutfitsProvider(_generateParams));
            },
            tooltip: 'Régénérer',
          ),
        ],
      ),
      body: outfitsAsync.when(
        data: (outfits) {
          print('Outfits générés : $outfits');
           _buildOutfitsList(outfits);
        },
        loading: () {
          print('Chargement des outfits...');
          _buildLoadingState();
        },
        error: (error, stackTrace) {
          print('Erreur lors de la génération des outfits : $error');
           _buildErrorState(error.toString());
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Génération des outfits en cours...'),
        ],
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Erreur',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.red,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Erreur lors de la génération: $errorMessage',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(generateOutfitsProvider(_generateParams));
              },
              child: const Text('Réessayer'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutfitsList(List<Outfit> outfits) {
    if (outfits.isEmpty) {
      return const Center(
        child: Text('Aucun outfit généré'),
      );
    }

    return  Center( child: Text("CC"),);
    // return ListView.builder(
    //   itemCount: outfits.length,
    //   itemBuilder: (context, index) {
    //     final outfit = outfits[index];
    //     return Card(
    //       margin: const EdgeInsets.all(8.0),
    //       child: ListTile(
    //         title: Text(outfit.style),
    //         subtitle: Text('Nombre de vêtements : ${outfit.garments.length}'),
    //         onTap: () {
    //           // Action sur le clic d'un outfit
    //         },
    //       ),
    //     );
    //   },
    // );
  }

  Widget _buildOutfitCard(Outfit outfit, int outfitNumber) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête de l'outfit
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Outfit $outfitNumber',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                ),
                Text(
                  outfit.style,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Liste des vêtements
            if (outfit.garments.isNotEmpty) ...[
              Text(
                'Vêtements (${outfit.garments.length}):',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: outfit.garments.length,
                  itemBuilder: (context, garmentIndex) {
                    final garment = outfit.garments[garmentIndex];
                    return _buildGarmentItem(garment);
                  },
                ),
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      'Aucun vêtement associé à cet outfit',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 16),

            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    // TODO: Implémenter l'ajout aux favoris
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fonctionnalité à implémenter'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.favorite_border),
                  label: const Text('Sauvegarder'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implémenter le partage
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fonctionnalité à implémenter'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('Partager'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGarmentItem(Garment garment) {
    print(
        'Affichage garment: ${garment.id}, URL: ${garment.imageUrl}'); // Debug

    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image du vêtement
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: garment.imageUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.network(
                        garment.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          print(
                              'Erreur chargement image: $error pour ${garment.imageUrl}');
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                                size: 24,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Image\nindisponible',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                          size: 32,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Pas d\'image',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 4),

          // Informations du vêtement
          Text(
            garment.subcategory.isNotEmpty ? garment.subcategory : 'Vêtement',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (garment.description != null && garment.description!.isNotEmpty)
            Text(
              garment.description!,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
