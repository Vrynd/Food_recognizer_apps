import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_recognizer_app/controller/home_provider.dart';
import 'package:provider/provider.dart';

class CameraOrGalleryWidget extends StatelessWidget {
  const CameraOrGalleryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Ambil atau Unggah',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Arahkan kamera ke makanan yang ingin diidentifikasi',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        Consumer<HomeProvider>(
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
                      onPressed: () {},
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
                        context.read<HomeProvider>().clearImage();
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
                    onPressed: () => context.read<HomeProvider>().openCamera(),
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      size: 100,
                      color: Theme.of(context).colorScheme.surfaceDim,
                    ),
                  ),
                ),
              );
            }
          },
        ),

        const SizedBox(height: 24),
        Text(
          'Apabila kesulitan mengidentifikasi makanan dengan kamera, anda dapat menggunakan metode upload gambar sebagai alternatif',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
