import 'package:flutter/material.dart';

class IncomeItem {
  IconData icon;
  String categoryName;
  String amount;
  DateTime timestamp;

  IncomeItem({
    required this.icon,
    required this.categoryName,
    required this.amount,
    required this.timestamp,
  });
}
