import 'package:flutter/material.dart';
import 'package:udemy_todoapp/models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {

    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => Text(
        meals[index].title,
      ),
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
      appBar: AppBar(
        title: Text(title),
      ),
      body: content,
    );
  }
}
