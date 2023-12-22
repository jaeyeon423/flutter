import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 15.69,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(context: context, builder: (ctx){return Text('Modal botoom sheet');});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Expense Tracker"),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Text('The chart'),
          Expanded(
              child: ExpensesList(
            expense: _registeredExpenses,
          )),
        ],
      ),
    );
  }
}
