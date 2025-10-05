import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_recognizer_app/controller/image_classification_provider.dart';
import 'package:food_recognizer_app/controller/image_preview_provider.dart';
import 'package:food_recognizer_app/widget/home_body_widget.dart';
import 'package:food_recognizer_app/widget/scaffold_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWigdet(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        title: Text(
          'Food Recognizer',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: const HomeBodyWidget(),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 52),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  elevation: 0,
                ),
                onPressed: () async {
                  final imagePath = context
                      .read<ImagePreviewProvider>()
                      .imagePath;
                  if (imagePath != null) {
                    final file = File(imagePath);
                    await context
                        .read<ImageClassificationProvider>()
                        .runClassification(file);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).colorScheme.errorContainer,
                        duration: const Duration(seconds: 2),
                        padding: const EdgeInsets.all(16),
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          "Ambil atau unggah gambar terlebih dahulu",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onErrorContainer,
                              ),
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  'Identifikasi Gambar',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Builder(
                builder: (context) => ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: Size(double.infinity, 52),
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHigh,
                    elevation: 0,
                  ),
                  onPressed: () =>
                      context.read<ImagePreviewProvider>().openGallery(),
                  label: Icon(
                    Icons.image_outlined,
                    size: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
