import 'dart:math';

import 'package:course1_roll_dice/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

import '../../models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({Key? key, required this.expense, required this.onRemoveExpense}) : super(key: key);

  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expense[index]),
        onDismissed: (direction) {
          onRemoveExpense(expense[index]);
        },
        child: ExpenseItem(expense: expense[index]),
      ),
    );
  }
}
