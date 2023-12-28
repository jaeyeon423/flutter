import 'package:flutter/material.dart';
import 'package:udemy_todoapp/models/meal.dart';
import 'package:udemy_todoapp/screens/meal_details.dart';
import 'package:udemy_todoapp/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  final String title;
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MealDetails(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {

    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(meal: meals[index], onSelectMeal: (meals){selectMeal(context, meals);} ,),
    );

    if(meals.isEmpty){
      content = Center(child: Column(
        children: [
          const Text('uh oh ... nothing here', style: TextStyle(color: Colors.white),),
          const SizedBox(height: 16,),
          Text('Try selecting a different category!', style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),),
        ],
      ),);
    }

    return Scaffold(
      body: content,
    );
  }
}
