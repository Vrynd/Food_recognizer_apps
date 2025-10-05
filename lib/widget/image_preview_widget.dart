import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_recognizer_app/controller/image_preview_provider.dart';
import 'package:provider/provider.dart';

class CameraOrGalleryWidget extends StatelessWidget {
  const CameraOrGalleryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ImagePreviewProvider>(
      builder: (context, provider, child) {
        if (provider.imagePath != null) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  File(provider.imagePath!),
                  height: 450,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 14,
                left: 14,
                child: IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(
                        context,
                      ).colorScheme.inverseSurface.withValues(alpha: .4),
                    ),
                  ),
                  icon: Icon(
                    Icons.crop_outlined,
                    size: 26,
                    color: Theme.of(context).colorScheme.onInverseSurface,
                  ),
                  onPressed: () {
                    final provider = context.read<ImagePreviewProvider>();
                    if (provider.imagePath != null) {
                      provider.cropImage(provider.imagePath!);
                    }
                  },
                ),
              ),
              Positioned(
                top: 14,
                right: 14,
                child: IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(
                        context,
                      ).colorScheme.inverseSurface.withValues(alpha: .4),
                    ),
                  ),
                  icon: Icon(
                    Icons.delete_outline,
                    size: 26,
                    color: Theme.of(context).colorScheme.onInverseSurface,
                  ),
                  onPressed: () {
                    context.read<ImagePreviewProvider>().clearImage();
                  },
                ),
              ),
            ],
          );
        } else {
          return Container(
            width: double.infinity,
            height: 450,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: IconButton(
                onPressed: () =>
                    context.read<ImagePreviewProvider>().openCamera(),
                icon: Icon(
                  Icons.camera_outlined,
                  size: 100,
                  color: Theme.of(context).colorScheme.surfaceDim,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
