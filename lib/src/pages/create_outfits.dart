import 'package:dresscode/src/constants/colors.dart';
import 'package:dresscode/src/models/garment.model.dart';
import 'package:dresscode/src/providers/garment_providers.dart';
import 'package:dresscode/src/providers/outfit_providers.dart';
import 'package:dresscode/src/widgets/selectable_garment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateOutfitPage extends ConsumerStatefulWidget {
  const CreateOutfitPage({super.key});

  @override
  ConsumerState<CreateOutfitPage> createState() => _CreateOutfitPageState();
}

class _CreateOutfitPageState extends ConsumerState<CreateOutfitPage> {
  final Set<int> selectedIndices = {};
  final int minimumGarments = 3;

  void handleSelection(int index, bool selected) {
    setState(() {
      if (selected) {
        selectedIndices.add(index);
      } else {
        selectedIndices.remove(index);
      }
    });
  }

  Future<void> saveOutfit(List<Garment> garments) async {
    if (selectedIndices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Veuillez sélectionner au moins un vêtement.')),
      );
      return;
    }

    // Récupérer les IDs des vêtements sélectionnés
    final selectedGarmentIds =
        selectedIndices.map((i) => garments[i].id).toList();

    try {
      // Appeler le provider pour créer un Outfit
      await ref.read(createOutfitProvider({
        'style': 'Personnalisé', // Style par défaut
        'garments': selectedGarmentIds,
      }).future);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Outfit enregistré avec succès !')),
      );

      // Réinitialiser les sélections après l'enregistrement
      setState(() {
        selectedIndices.clear();
      });

      // Retourner à la page précédente
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'enregistrement : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final garments = ref.watch(garmentsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Créer un outfit',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: AppColors.disabledColor,
      body: garments.when(
        data: (garmentsList) => Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: garmentsList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) => SelectableGarmentCard(
                    imageUrl: garmentsList[index].imageUrl,
                    initiallySelected: selectedIndices.contains(index),
                    onSelectionChanged: (selected) =>
                        handleSelection(index, selected),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                onPressed: selectedIndices.isNotEmpty
                ? () => saveOutfit(garmentsList)
                : null,
                icon: const Icon(Icons.check, color: Colors.white),
                label: const Text(
                  'Enregistrer l’outfit',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text(
            'Erreur : $error',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
