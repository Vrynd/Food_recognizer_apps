import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_recognizer_app/controller/image_classification_provider.dart';
import 'package:food_recognizer_app/data/models/meal.dart';
import 'package:provider/provider.dart';

class ResultBodyWidget extends StatelessWidget {
  final String? imagePath;
  final Meal meal;

  const ResultBodyWidget({
    super.key,
    required this.imagePath,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    final classifications = context
        .read<ImageClassificationProvider>()
        .classificationsThree;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.broken_image_outlined,
                    size: 80,
                    color: Theme.of(context).colorScheme.surfaceDim,
                  ),
                  const SizedBox(height: 10),
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

          Text(
            "Hasil Identifikasi",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),

          ResultIdentification(classifications: classifications),
          const SizedBox(height: 24),

          Text(
            "Bahan-bahan:",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),

          if (meal.ingredients.isNotEmpty)
            FoodIngredients(meal: meal)
          else
            Text(
              "Tidak ada data bahan-bahan tersedia.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
        ],
      ),
    );
  }
}

class FoodIngredients extends StatelessWidget {
  const FoodIngredients({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: meal.ingredients.length,
        itemBuilder: (context, index) {
          final ingredient = meal.ingredients[index];
          return ListTile(
            dense: true,
            leading: CircleAvatar(
              radius: 14,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: .1),
              child: Text(
                "${index + 1}",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            title: Text(
              ingredient,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          );
        },
      ),
    );
  }
}

class ResultIdentification extends StatelessWidget {
  const ResultIdentification({super.key, required this.classifications});

  final Map<String, double> classifications;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: classifications.length,
        itemBuilder: (context, index) {
          final entry = classifications.entries.elementAt(index);
          final confidence = (entry.value * 100).toStringAsFixed(1);

          IconData iconData;
          Color iconColor;

          if (index == 0) {
            iconData = Icons.emoji_events;
            iconColor = Colors.amber;
          } else if (index == 1) {
            iconData = Icons.emoji_events_outlined;
            iconColor = Colors.grey;
          } else if (index == 2) {
            iconData = Icons.military_tech;
            iconColor = Colors.brown;
          } else {
            iconData = Icons.label_outline;
            iconColor = Theme.of(context).colorScheme.primary;
          }

          return ListTile(
            leading: Icon(iconData, color: iconColor, size: 28),
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
        separatorBuilder: (context, index) =>
            Divider(color: Theme.of(context).colorScheme.surfaceDim, height: 1),
      ),
    );
  }
}
