import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:food_recognizer_app/data/models/meal.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const _baseUrl = "https://www.themealdb.com/api/json/v1/1";

  Future<Meal?> getMealDetails(String query) async {
    final cleanedQuery = query.trim();

    try {
      final meal = await _fetchMeal(cleanedQuery);
      if (meal == null && cleanedQuery.contains(' ')) {
        final fallback = cleanedQuery.split(' ').first;
        return await _fetchMeal(fallback);
      }

      return meal;
    } on SocketException {
      throw Exception("Tidak ada koneksi internet. Periksa jaringan Anda.");
    } on TimeoutException {
      throw Exception("Koneksi timeout. Coba lagi beberapa saat.");
    } catch (e) {
      throw Exception("Terjadi kesalahan: $e");
    }
  }

  Future<Meal?> _fetchMeal(String query) async {
    final uri = Uri.parse("$_baseUrl/search.php?s=$query");
    final response = await http.get(uri).timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception("Gagal memuat data dari server (status: ${response.statusCode}).");
    }

    final data = jsonDecode(response.body);
    final meals = data['meals'];

    if (meals == null || meals.isEmpty) return null;
    return Meal.fromJson(meals[0]);
  }
}
