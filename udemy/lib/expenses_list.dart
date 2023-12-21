import 'package:flutter/material.dart';

import 'models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({Key? key, required this.expense}) : super(key: key);

  final List<Expense> expense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (ctx, index) => Text(expense[index].title),
    );
  }
}
