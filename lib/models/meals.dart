class Meal {
  final String name;
  final String imageUrl;
  final String instructions;
  final String? youtubeUrl;
  final List<Map<String, String>> ingredients;

  Meal({
    required this.name,
    required this.imageUrl,
    required this.instructions,
    this.youtubeUrl,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<Map<String, String>> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (ingredient != null &&
          ingredient.isNotEmpty &&
          measure != null &&
          measure.isNotEmpty) {
        ingredients.add({
          'ingredient': ingredient,
          'measure': measure,
        });
      }
    }

    return Meal(
      name: json['strMeal'],
      imageUrl: json['strMealThumb'],
      instructions: json['strInstructions'],
      youtubeUrl: json['strYoutube'],
      ingredients: ingredients,
    );
  }
}
