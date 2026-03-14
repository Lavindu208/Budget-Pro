import 'package:flutter/material.dart';

class ExpenseItem {
  IconData icon;
  String categoryName;
  String amount;

  ExpenseItem({
    required this.icon,
    required this.categoryName,
    required this.amount,
  });
}

class HomeScreenExpenses {
  static List<ExpenseItem>? homeScreenExpenseItems;

  HomeScreenExpenses({List? homeScreenExpenseItems});
}
