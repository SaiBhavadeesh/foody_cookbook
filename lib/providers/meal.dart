import 'dart:convert';

import 'package:http/http.dart' as http;

class MealDemo {
  String meal;
  String thumb;
  String mealId;
  bool isFav;

  MealDemo(
      {required this.meal,
      required this.thumb,
      required this.mealId,
      this.isFav = false});

  factory MealDemo.fromJson(Map<String, dynamic> doc) => MealDemo(
      meal: doc['strMeal'], thumb: doc['strMealThumb'], mealId: doc['idMeal']);
}

class MealDetails {
  String meal;
  String mealId;
  String category;
  String thumb;
  String area;
  String youtubelnk;
  String instructions;
  List<String> ingredients;
  List<String> measure;

  MealDetails(
      {required this.meal,
      required this.mealId,
      required this.category,
      required this.thumb,
      required this.area,
      required this.youtubelnk,
      required this.instructions,
      required this.ingredients,
      required this.measure});

  factory MealDetails.fromMap(Map<String, dynamic> doc) => MealDetails(
      meal: doc['strMeal'],
      mealId: doc['idMeal'],
      category: doc['strCategory'],
      thumb: doc['strMealThumb'],
      area: doc['strArea'],
      youtubelnk: doc['strYoutube'],
      instructions: doc['strInstructions'],
      ingredients: [''],
      measure: ['']);
}

Future<List<MealDemo>> getMealItems() async {
  List<MealDemo> mealsList = [];
  final res = await http
      .get(Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php"));
  if (res.statusCode == 200) {
    final cat = jsonDecode(res.body)['categories'];
    for (int i = 0; i < cat.length; i++) {
      final url =
          "https://www.themealdb.com/api/json/v1/1/filter.php?c=${cat[i]['strCategory']}";
      final catres = await http.get(Uri.parse(url));
      if (catres.statusCode == 200) {
        final meals = jsonDecode(catres.body)['meals'];
        for (int j = 0; j < meals.length; j++) {
          mealsList.add(MealDemo.fromJson(meals[j]));
        }
      }
    }
    return mealsList;
  } else
    return mealsList;
}

Future<MealDetails?> getMealData(String id) async {
  final url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id";
  final details = await http.get(Uri.parse(url));
  if (details.statusCode == 200) {
    final meals = jsonDecode(details.body)['meals'][0];
    List<String> ing = [];
    List<String> msr = [];
    try {
      for (int i = 1; i < 21; i++) {
        if (meals['strIngredient$i'].isNotEmpty)
          ing.add(meals['strIngredient$i']);
        if (meals['strMeasure$i'].isNotEmpty) msr.add(meals['strMeasure$i']);
      }
    } catch (err) {}
    return MealDetails.fromMap(meals)
      ..ingredients = ing
      ..measure = msr;
  }
}
