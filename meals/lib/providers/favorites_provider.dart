import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>>{
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal){
    final mealIsFavorite = state.contains(meal);

    if(mealIsFavorite){
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    }else{
      state = [...state, meal];
      return true;
    }
  }

}

final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref)  {
  return FavoriteMealsNotifier();
});