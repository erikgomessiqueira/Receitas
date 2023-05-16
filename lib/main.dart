import 'package:flutter/material.dart';
import 'package:receitas/mock/data/dummy_data.dart';
import 'package:receitas/models/meal.dart';
import 'package:receitas/models/settings.dart';
import 'package:receitas/screens/categories.dart';
import 'package:receitas/screens/categories_meals.dart';
import 'package:receitas/screens/meal_detail.dart';
import 'package:receitas/screens/settings.dart';
import 'package:receitas/screens/tabs.dart';
import 'package:receitas/utils/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();
  List<Meal> _avaliableMeals = dummyMeals;
  List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      _avaliableMeals = dummyMeals.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;

        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = ThemeData();
    return MaterialApp(
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.pink,
          secondary: Colors.amber,
        ),
        textTheme: theme.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 20,
          ),
        ),
        floatingActionButtonTheme: theme.floatingActionButtonTheme.copyWith(
          backgroundColor: Colors.pink,
        ),
        appBarTheme: theme.appBarTheme.copyWith(
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontFamily: 'Raleway',
          ),
        ),
      ),
      routes: {
        AppRoutes.home: (context) => TabsScreen(favoriteMeals: _favoriteMeals),
        AppRoutes.categoriesMeals: (context) =>
            CategoriesMealsScreen(meals: _avaliableMeals),
        AppRoutes.mealDetail: (context) => MealDetailScreen(
            onToggleFavorite: _toggleFavorite, isFavorite: _isFavorite),
        AppRoutes.settings: (context) {
          return SettingsScreen(
            onSettingsChange: _filterMeals,
            settings: settings,
          );
        },
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const CategoriesScreen(),
        );
      },
    );
  }
}
