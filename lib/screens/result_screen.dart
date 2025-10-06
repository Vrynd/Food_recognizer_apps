import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_recognizer_app/controller/image_classification_provider.dart';
import 'package:food_recognizer_app/controller/meal_provider.dart';
import 'package:food_recognizer_app/data/models/meal.dart';
import 'package:food_recognizer_app/static/meal_result_state.dart';
import 'package:food_recognizer_app/widget/scaffold_widget.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatefulWidget {
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
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MealProvider>().fetchMeal(widget.label);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWigdet(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        title: Text(
          widget.label,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Consumer<MealProvider>(
        builder: (context, provider, _) {
          final state = provider.state;

          if (state is MealLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MealErrorState) {
            return Center(child: Text(state.message));
          } else if (state is MealLoadedState) {
            return ResultBodyWidget(
              imagePath: widget.imagePath,
              meal: state.meal,
            );
          }

          return const Center(child: Text("Memuat hasil..."));
        },
      ),
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
          onPressed: () async {
            // nanti diisi untuk fitur “Lihat Nutrisi”
          },
          child: Text(
            'Lihat Nutrisi',
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

          Container(
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
              separatorBuilder: (context, index) => Divider(
                color: Theme.of(context).colorScheme.surfaceDim,
                height: 1,
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            "Bahan-bahan:",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),

          if (meal.ingredients.isNotEmpty)
            Container(
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            )
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
