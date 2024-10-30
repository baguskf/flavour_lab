import 'dart:convert';

ListCategoryModel listCategoryModelFromJson(String str) =>
    ListCategoryModel.fromJson(json.decode(str));

String listCategoryModelToJson(ListCategoryModel data) =>
    json.encode(data.toJson());

class ListCategoryModel {
  List<Meal> meals;

  ListCategoryModel({
    required this.meals,
  });

  factory ListCategoryModel.fromJson(Map<String, dynamic> json) =>
      ListCategoryModel(
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class Meal {
  String strMeal;
  String strMealThumb;
  String idMeal;

  Meal({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
        idMeal: json["idMeal"],
      );

  Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
      };
}
