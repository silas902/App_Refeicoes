import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:refeicoes/screens/meal_detail_scree.dart';
import 'screens/categories_melas_screen.dart';
import 'screens/meal_detail_scree.dart';
import 'utils/app_routes.dart';
import 'screens/tabs_screen.dart';
import 'screens/setting_screens.dart';
import 'models/meal.dart';
import 'data/dummy_data.dart';
import 'models/settings.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Meal> _availableMeals = DUMMY_MEALS;

  void _filterMeals(Settings settings) {
    setState(() {
      _availableMeals = DUMMY_MEALS.where((meal) {
        final filterGluten = settings.isGlutenFree! && meal.isGlutenFree!;
        final filterLactose = settings.isLactoseFree! && meal.isLactoseFree!;
        final filterVegan = settings.isVegan! && !meal.isVegan!;
        final filterVegetarian = settings.isVegetarian! && meal.isVegetarian!;
        return filterGluten && filterLactose && filterVegan && filterVegetarian;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title: 'Vamaos Cozinhar?',
      theme: ThemeData(        
        primarySwatch: Colors.pink,
        // ignore: deprecated_member_use
        accentColor: Colors.amber,
        fontFamily: 'Raleway',
        canvasColor: Color.fromRGBO(255,254,229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
          subtitle1: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
          )
        ),
      ),
    
      routes: {
        AppRoutes.HOME: (ctx) => TabsScreen(),
        AppRoutes.CATEGORIES_MEAS: (ctx) => CategoriesMealsScreen(_availableMeals),
        AppRoutes.MEAL_DETAIL: (ctx) => MealDetailScreen(),
        AppRoutes.SETTINGS: (ctx) => SettingsScreen(_filterMeals),
      },
    );
  }
}
