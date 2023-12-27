import 'package:flutter/material.dart';
import 'package:udemy_todoapp/models/meal.dart';

class MealDetails extends StatelessWidget {
  const MealDetails({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: Image.network(meal.imageUrl, width: double.infinity , height: 300, fit: BoxFit.fill,),
    );
  }
}
