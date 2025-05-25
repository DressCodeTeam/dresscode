import 'package:dresscode/src/constants/colors.dart';
import 'package:dresscode/src/hooks/use_side_effect.dart';
import 'package:dresscode/src/models/garment.model.dart';
import 'package:dresscode/src/providers/garment_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClosetPage extends HookConsumerWidget {
  const ClosetPage({ super.key });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final garmentEffect = useSideEffect<Garment>();
    final garmentService = ref.watch(garmentServiceProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Garde-robe',
          style: TextStyle(color: Colors.white)
        ),
        backgroundColor: AppColors.primaryColor.withAlpha(200),
      ),
      body: Column(
        children: [
          // Display garmentEffect status
          garmentEffect.snapshot.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            // TODO(aman): replace by error page or dialog
            error: (error, stack) => Text('Error: $error'), 
            data: (garment) => garment != null 
                ? const Text('Garment successfully created !') 
                : const SizedBox.shrink(),
          ),

          // Display garments list
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final garmentsAsync = ref.watch(garmentsProvider);

                return garmentsAsync.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator()
                  ),
                  error: (error, _) => Center(child: Text('Error: $error')),
                  data: (garments) => ListView.builder(
                    itemCount: garments.length,
                    itemBuilder: (context, index) {
                      final garment = garments[index];
                      return ListTile(
                        title: Text('Garment ${garment.id}'),
                        subtitle: Text('Created: ${garment.createdAt}'),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
