import 'package:flutter/material.dart';
import 'package:food_recognizer_app/data/api/api_service.dart';
import 'package:food_recognizer_app/static/meal_result_state.dart';

class MealProvider extends ChangeNotifier {
  final ApiService _apiService;
  MealProvider(this._apiService);

  MealResultState _state = MealNoneState();
  MealResultState get state => _state;

  Future<void> fetchMeal(String query) async {
    try {
      _state = MealLoadingState();
      notifyListeners();

      final result = await _apiService.getMealDetails(query);
      if (result != null) {
        _state = MealLoadedState(result);
      } else {
        _state = MealErrorState("Data tidak ditemukan untuk \"$query\"");
      }
    } catch (e) {
      _state = MealErrorState(e.toString());
    }
    notifyListeners();
  }
}
