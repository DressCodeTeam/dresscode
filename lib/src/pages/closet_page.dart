import 'package:dresscode/src/widgets/garment_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClosetPage extends ConsumerWidget {
  const ClosetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      mainAxisSpacing: 12,
      crossAxisCount: 2,
      children: List.generate(10, (index) {
        return GarmentCard();
      }),
    );
  }
}