import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dresscode/src/constants/colors.dart';
import 'package:dresscode/src/hooks/use_side_effect.dart';
import 'package:dresscode/src/models/garment.model.dart';
import 'package:dresscode/src/providers/camera_providers.dart';
import 'package:dresscode/src/providers/garment_providers.dart';
import 'package:dresscode/src/widgets/category_buttons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CameraPage extends HookConsumerWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraControllerAsync = ref.watch(cameraControllerProvider);
    final capturedImage = ref.watch(capturedImageProvider);
    final uploadEffect = useSideEffect<Garment>();
    final photoService = ref.watch(garmentServiceProvider);

    // Actions après upload réussi
    final uploadSnapshot = uploadEffect.snapshot;
    if (uploadSnapshot.hasData && uploadSnapshot.data != null) {
      // Action unique après succès
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.invalidate(garmentsProvider);
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted) {
            Navigator.pop(context);
          }
        });
      });
    }

    Future<void> takePicture() async {
      final controller = ref.read(cameraControllerProvider.notifier);
      final image = await controller.takePicture();
      if (image != null) {
        ref.read(capturedImageProvider.notifier).state = image;
      } else {
        _showSnackBar(
          context,
          'Erreur lors de la prise de photo'
        );
      }
    }

    Future<void> uploadPhoto() async {
      final image = capturedImage;
      if (image == null) return;

      uploadEffect.mutate(
        photoService.uploadGarmentPhoto(
          imageFile: image,
        ),
      );
    }

    void retakePhoto() {
      ref.read(capturedImageProvider.notifier).state = null;
      uploadEffect.clear();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          capturedImage != null ? 'Aperçu' : 'Prendre une photo',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          // Zone de prévisualisation
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: capturedImage != null
                    ? Image.file(
                        capturedImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : cameraControllerAsync.when(
                        loading: () => const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        error: (error, _) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.camera_alt_outlined,
                                size: 64,
                                color: Colors.white54,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Erreur caméra: $error',
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        data: (controller) => controller != null
                            ? CameraPreview(controller)
                            : const Center(
                                child: Text(
                                  'Caméra non disponible',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                      ),
              ),
            ),
          ),

          // Status de l'upload
          uploadEffect.snapshot.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  CircularProgressIndicator(color: AppColors.secondaryColor),
                  SizedBox(height: 8),
                  Text(
                    'Envoi en cours...',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            error: (error, _) => Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Erreur: $error',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            data: (garment) => garment != null
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 32,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Vêtement ajouté avec succès !',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          // Contrôles de la caméra
          Container(
            padding: const EdgeInsets.all(24),
            child: capturedImage == null
                ? _buildCameraControls(
                    takePicture,
                    cameraControllerAsync.hasValue,
                  )
                : _buildPreviewControls(
                    retakePhoto,
                    uploadPhoto,
                    uploadEffect.snapshot.connectionState == ConnectionState.waiting,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraControls(VoidCallback onTakePicture, bool isReady) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: isReady ? onTakePicture : null,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isReady ? Colors.white : Colors.grey,
              border: Border.all(
                color: AppColors.secondaryColor,
                width: 4,
              ),
            ),
            child: Icon(
              Icons.camera_alt,
              size: 40,
              color: isReady ? Colors.black : Colors.white54,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewControls(
    VoidCallback onRetake,
    VoidCallback onSave,
    bool isUploading,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Reprendre la photo
        IconButton(
          onPressed: isUploading ? null : onRetake,
          icon: const Icon(Icons.refresh, size: 32),
          color: Colors.white,
          tooltip: 'Reprendre',
        ),
        // Sauvegarder
        ElevatedButton.icon(
          onPressed: isUploading ? null : onSave,
          icon: isUploading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.save),
          label: Text(isUploading ? 'Envoi...' : 'Sauvegarder'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
