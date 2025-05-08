import 'package:dresscode/src/hooks/use_side_effect.dart';
import 'package:dresscode/src/models/garment.model.dart';
import 'package:dresscode/src/widgets/garment_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClosetPage extends ConsumerWidget {
  const ClosetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final garment = useSideEffect<Garment>();

    garment.mutate(fetchGarments());

    return garment.snapshot.when(
      loading: () => const CircularProgressIndicator(),
      // TODO(aman): create a customizable error
      // page for critical errors
      error: (err, _) => Text('$err'),
      data: (List<Garment> garments) => GridView.count();
    );
  }
}
