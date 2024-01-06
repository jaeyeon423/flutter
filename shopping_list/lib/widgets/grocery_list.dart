import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
        'flutter-prep-b9c1c-default-rtdb.firebaseio.com', 'shopping-list.json');
    final response = await http.get(url);

    if(response.statusCode >= 400) {
      setState(() {
        _error = 'Failed to fetch data. Please try again later';
      });
    }
    final Map<String, dynamic> listData =
        json.decode(response.body);
    final List<GroceryItem> loadItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category']).value;
      loadItems.add(GroceryItem(
            id: item.key, name: item.value['name'], quantity: item.value['quantity'], category: category),);
    }

    setState(() {
      _groceryItems = loadItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _addItem() async {
      final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(
          builder: (ctx) => NewItem(),
        ),
      );

      if(newItem == null){
        return;
      }

      setState(() {
        _groceryItems.add(newItem);
        _isLoading = false;
      });
    }

    void _removeItem(GroceryItem item)  async{
      final index = _groceryItems.indexOf(item);
      setState(() {
        _groceryItems.remove(item);
      });

      final url = Uri.https(
          'flutter-prep-b9c1c-default-rtdb.firebaseio.com', 'shopping-list/${item.id}.json');
      final response = await http.delete(url);

      if(response.statusCode >= 400){
        setState(() {
          _groceryItems.insert(index, item);
        });
      }


    }

    Widget content = const Center(
      child: Text('No Items Added yet'),
    );

    if(_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removeItem(_groceryItems[index]);
          },
          key: ValueKey(_groceryItems[index].id),
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(_groceryItems[index].quantity.toString()),
          ),
        ),
        itemCount: _groceryItems.length,
      );
    }

    if(_error != null){
      content = Center(child: Text(_error!),);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(onPressed: _addItem, icon: Icon(Icons.add)),
        ],
      ),
      body: content,
    );
  }
}
