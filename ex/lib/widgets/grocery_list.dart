import 'package:ex/data/dummy_items.dart';
import 'package:ex/widgets/new_item.dart';
import 'package:flutter/material.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key});

  @override
  Widget build(BuildContext context) {

    void _addItem(){
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => const NewItem())
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Grocery'),
        actions: [
          IconButton(onPressed: _addItem, icon: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(groceryItems[index].name),
          leading: Container(
            width: 24,
            height: 24,
            color: groceryItems[index].category.color,
          ),
          trailing: Text(
            groceryItems[index].quantity.toString(),
          ),
        ),
      ),
    );
  }
}
