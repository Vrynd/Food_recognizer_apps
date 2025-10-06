import 'package:flutter/material.dart';
import 'package:food_recognizer_app/controller/image_classification_provider.dart';
import 'package:food_recognizer_app/controller/image_preview_provider.dart';
import 'package:food_recognizer_app/routes/route_navigation.dart';
import 'package:food_recognizer_app/widget/image_preview_widget.dart';
import 'package:provider/provider.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
        children: [
          const SizedBox(height: 16),

          Text(
            'Yuk, Kenali Makananmu!',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          Text(
            'Ambil atau unggah foto makananmu, dan temukan hasil identifikasinya',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          const ImagePreviewWidget(),

          const SizedBox(height: 24),

          Consumer<ImageClassificationProvider>(
            builder: (context, provider, child) {
              final classifications = provider.classifications;
              if (classifications.isEmpty) {
                return EmptyStateTile();
              }

              final entry = classifications.entries.first;
              return ResultStateTile(
                label: entry.key,
                confidence: entry.value.toDouble(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class EmptyStateTile extends StatelessWidget {
  const EmptyStateTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text("Nama Makanan"),
      trailing: Text(
        "0.0%",
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class ResultStateTile extends StatelessWidget {
  final String label;
  final double confidence;

  const ResultStateTile({
    super.key,
    required this.label,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(label),
      trailing: Text(
        "${(confidence * 100).toStringAsFixed(1)}%",
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () {
        final imageProvider = context.read<ImagePreviewProvider>();
        Navigator.pushNamed(
          context,
          RouteNavigation.result.name,
          arguments: {
            "label": label,
            "confidence": confidence,
            "imagePath": imageProvider.imagePath,
          },
        );
      },
    );
  }
}
