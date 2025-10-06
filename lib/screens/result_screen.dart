import 'package:flutter/material.dart';
import 'package:food_recognizer_app/controller/meal_provider.dart';
import 'package:food_recognizer_app/static/meal_result_state.dart';
import 'package:food_recognizer_app/widget/result_body_widget.dart';
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
        builder: (context, provider, child) {
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
          } else {
            return const Center(child: Text("Memuat hasil..."));
          }
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
          onPressed: () async {},
          child: Text(
            'Lihat Cara Pembuatan',
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
