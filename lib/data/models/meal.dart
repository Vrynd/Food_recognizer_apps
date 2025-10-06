class Meal {
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String? imageUrl;
  final List<String> ingredients;

  Meal({
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    this.imageUrl,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null &&
          ingredient.toString().trim().isNotEmpty &&
          measure != null &&
          measure.toString().trim().isNotEmpty) {
        ingredients.add("${measure.toString().trim()} ${ingredient.toString().trim()}");
      } else if (ingredient != null &&
          ingredient.toString().trim().isNotEmpty) {
        ingredients.add(ingredient.toString().trim());
      }
    }

    return Meal(
      name: json['strMeal'] ?? 'Tidak diketahui',
      category: json['strCategory'] ?? 'Tidak diketahui',
      area: json['strArea'] ?? 'Tidak diketahui',
      instructions: json['strInstructions'] ?? 'Instruksi tidak tersedia',
      imageUrl: json['strMealThumb'],
      ingredients: ingredients,
    );
  }
}