import 'package:dresscode/src/widgets/selectable_garment_card.dart';
import 'package:flutter/material.dart';

class CreateOutfitPage extends StatefulWidget {
  const CreateOutfitPage({super.key});

  @override
  State<CreateOutfitPage> createState() => _CreateOutfitPageState();
}

class _CreateOutfitPageState extends State<CreateOutfitPage> {
  final List<String> allGarments = List.generate(
    12,
    (i) => 'https://picsum.photos/id/${i + 10}/200',
  );

  final Set<int> selectedIndices = {};

  void handleSelection(int index, bool selected) {
    setState(() {
      if (selected) {
        selectedIndices.add(index);
      } else {
        selectedIndices.remove(index);
      }
    });
  }

  void saveOutfit() {
    final selectedGarments =
        selectedIndices.map((i) => allGarments[i]).toList();
    // Tu peux maintenant les utiliser pour créer un outfit
    debugPrint('Outfit saved with ${selectedGarments.length} vêtements');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crée ton propre Outfit'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: allGarments.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return SelectableGarmentCard(
              imageUrl: allGarments[index],
              initiallySelected: selectedIndices.contains(index),
              onSelectionChanged: (selected) =>
                  handleSelection(index, selected),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          onPressed: saveOutfit,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            backgroundColor: const Color(0xFF7861FF),
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
