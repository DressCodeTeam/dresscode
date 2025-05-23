import 'package:dresscode/src/models/garment.model.dart';
import 'package:dresscode/src/models/outfit.model.dart';
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
  final int minimumGarments = 3; // Nombre minimum de vêtements requis

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
    if (selectedIndices.length < minimumGarments) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez sélectionner au moins $minimumGarments vêtements.'),
        ),
      );
      return;
    }

    final selectedGarments =
        selectedIndices.map((i) => garments[i].id).toList();

    try {
      final outfitsService = ref.read(outfitsServiceProvider);
      await outfitsService.createOutfit(
        Outfit(
          id: -1,
          styleId: 1,
          createdAt: DateTime.now(),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Outfit enregistré avec succès !')),
      );

      // Réinitialiser les sélections après l'enregistrement
      setState(() {
        selectedIndices.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'enregistrement : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final garmentsAsyncValue = ref.watch(garmentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crée ton propre Outfit'),
        centerTitle: true,
      ),
      body: garmentsAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Erreur : $error'),
        ),
        data: (garments) => Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: garments.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final garment = garments[index];
              return SelectableGarmentCard(
                imageUrl: garment.imageUrl.toString(),
                initiallySelected: selectedIndices.contains(index),
                onSelectionChanged: (selected) =>
                    handleSelection(index, selected),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          onPressed: garmentsAsyncValue.maybeWhen(
            data: (garments) => () => saveOutfit(garments),
            orElse: () => null,
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            backgroundColor: selectedIndices.length >= minimumGarments
                ? const Color(0xFF7861FF)
                : Colors.grey,
          ),
          child: const Text(
            'Enregistrer l’Outfit',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}