import 'package:dresscode/src/pages/outfit_detail.dart';
import 'package:dresscode/src/widgets/outfits_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OutfitsPage extends ConsumerWidget {
  const OutfitsPage ({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<List<String>> outfits = [
      List.generate(9, (i) => 'https://picsum.photos/id/${i + 10}/100'),
      List.generate(9, (i) => 'https://picsum.photos/id/${i + 30}/100'),
      List.generate(9, (i) => 'https://picsum.photos/id/${i + 50}/100'),
    ];
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        children: outfits.map((images) {
          return OutfitsCard(
            //imageUrls: images,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OutfitDetailPage(imageUrls: images),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

/*GridView.count(
crossAxisCount: 2,
mainAxisSpacing: 12,
children : List.generate(10, (index) => const OutfitsCard()),
);*/