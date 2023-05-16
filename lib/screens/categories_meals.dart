import 'package:flutter/material.dart';
import 'package:receitas/components/meal_item.dart';
import 'package:receitas/models/category.dart';
import 'package:receitas/models/meal.dart';

class CategoriesMealsScreen extends StatelessWidget {
  final List<Meal> meals;
  const CategoriesMealsScreen({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;
    final categoryMeals = meals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(category.title),
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (context, index) {
          final meal = categoryMeals[index];
          return MealItem(meal: meal);
        },
      ),
    );
  }
}
