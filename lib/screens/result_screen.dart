import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_recognizer_app/controller/image_classification_provider.dart';
import 'package:food_recognizer_app/widget/scaffold_widget.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatelessWidget {
  final String label;
  final double confidence;
  final String? imagePath;

  const ResultScreen({
    super.key,
    required this.label,
    required this.confidence,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldWigdet(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        title: Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: ResultBodyWidget(imagePath: imagePath),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            minimumSize: const Size(double.infinity, 52),
            backgroundColor: Theme.of(context).colorScheme.primary,
            elevation: 0,
          ),
          onPressed: () async {},
          child: Text(
            'Lihat Bahan Makanan',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class ResultBodyWidget extends StatelessWidget {
  const ResultBodyWidget({super.key, required this.imagePath});
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final classifications = context
        .read<ImageClassificationProvider>()
        .classificationsThree;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  File(imagePath!),
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.surfaceContainerLowest,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.broken_image_outlined,
                      size: 80,
                      color: Theme.of(context).colorScheme.surfaceDim,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Gagal Memuat Gambar",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: classifications.length,
                itemBuilder: (context, index) {
                  final entry = classifications.entries.elementAt(index);
                  final confidence = (entry.value * 100).toStringAsFixed(1);

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      child: Text(
                        "${index + 1}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    title: Text(entry.key),
                    trailing: Text(
                      "$confidence%",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  color: Theme.of(context).colorScheme.surfaceDim,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
