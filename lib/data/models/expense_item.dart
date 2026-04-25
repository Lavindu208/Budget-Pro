import 'package:flutter/material.dart';

class ExpenseItem {
  IconData icon;
  String categoryName;
  String amount;
  DateTime timestamp;

  ExpenseItem({
    required this.icon,
    required this.categoryName,
    required this.amount,
    required this.timestamp,
  });
}

class HomeScreenExpenses {
  static List<ExpenseItem>? homeScreenExpenseItems;

  HomeScreenExpenses({List? homeScreenExpenseItems});
}
