import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final availableCamerasProvider = FutureProvider<List<CameraDescription>>(
  (ref) async { return await availableCameras(); }
);

final cameraControllerProvider = StateNotifierProvider<CameraControllerNotifier, AsyncValue<CameraController?>>((ref) {
  return CameraControllerNotifier(ref);
});

class CameraControllerNotifier
      extends
      StateNotifier<AsyncValue<CameraController?>> {
  CameraControllerNotifier(this._ref) : super(const AsyncValue.loading()) {
    _initializeCamera();
  }

  final Ref _ref;
  CameraController? _controller;


  Future<void> _initializeCamera() async {
    try {
      final cameras = await _ref.read(availableCamerasProvider.future);
      if (cameras.isEmpty) {
        state = AsyncValue.error('Aucune caméra disponible', StackTrace.current);
        return;
      }

      _controller = CameraController(
        cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _controller!.initialize();
      state = AsyncValue.data(_controller);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<File?> takePicture() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return null;

    try {
      final image = await controller.takePicture();
      return File(image.path);
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

final capturedImageProvider = StateProvider<File?>((ref) => null);

final selectedCategoryProvider = StateProvider<String>((ref) => 'Pulls');
