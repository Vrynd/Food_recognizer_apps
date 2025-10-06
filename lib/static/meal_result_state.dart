
import 'package:food_recognizer_app/data/models/meal.dart';

sealed class MealResultState {}

class MealNoneState extends MealResultState {}

class MealLoadingState extends MealResultState {}

class MealErrorState extends MealResultState {
  final String message;

  MealErrorState(this.message);
}

class MealLoadedState extends MealResultState {
  final Meal meal;

  MealLoadedState(this.meal);
}
