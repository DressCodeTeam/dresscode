import 'package:dresscode/src/constants/colors.dart';
import 'package:dresscode/src/constants/outfits_list.dart';
import 'package:dresscode/src/pages/create_outfits_ia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenerateOutfitsParamsPage extends ConsumerStatefulWidget {
  const GenerateOutfitsParamsPage({super.key});

  @override
  ConsumerState<GenerateOutfitsParamsPage> createState() => _GenerateOutfitsParamsPageState();
}

class _GenerateOutfitsParamsPageState extends ConsumerState<GenerateOutfitsParamsPage> {
  int? _selectedStyleId;
  String? _selectedWeather;
  int _nbOutfits = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Générer des Outfits'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sélection du style
            DropdownButtonFormField<int>(
              value: _selectedStyleId,
              decoration: const InputDecoration(
                labelText: 'Style',
                border: OutlineInputBorder(),
              ),
              items: OutfitConstants.styles.entries
                  .map((entry) => DropdownMenuItem(
                        value: entry.key,
                        child: Text(entry.value),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedStyleId = value),
              hint: const Text('Sélectionnez un style'),
            ),
            const SizedBox(height: 20),
            
            // Sélection de la météo
            DropdownButtonFormField<String>(
              value: _selectedWeather,
              decoration: const InputDecoration(
                labelText: 'Météo',
                border: OutlineInputBorder(),
              ),
              items: OutfitConstants.allWeather
                  .map((weather) => DropdownMenuItem(
                        value: weather,
                        child: Text(weather),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedWeather = value),
              hint: const Text('Sélectionnez une météo'),
            ),
            const SizedBox(height: 20),
            
            // Sélection du nombre d'outfits
            Row(
              children: [
                const Text('Nombre d\'outfits:'),
                const Spacer(),
                DropdownButton<int>(
                  value: _nbOutfits,
                  items: [1, 2, 3, 4, 5]
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text('$value'),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _nbOutfits = value ?? 3),
                ),
              ],
            ),
            const Spacer(),
            
            // Bouton de génération
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                if (_selectedStyleId == null || _selectedWeather == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez sélectionner un style et une météo')),
                  );
                  return;
                }
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GenerateOutfitsResultsPage(
                      styleId: _selectedStyleId!,
                      styleName: OutfitConstants.styles[_selectedStyleId]!,
                      weather: _selectedWeather!,
                      nbOutfits: _nbOutfits,
                    ),
                  ),
                );
              },
              child: const Text(
                'Générer les outfits',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}