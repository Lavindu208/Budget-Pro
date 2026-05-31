import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IncomeItem {
  IncomeCategory category;
  String amount;
  String note;
  DateTime timestamp;

  IncomeItem({
    required this.category,
    required this.amount,
    required this.note,
    required this.timestamp,
  });

  factory IncomeItem.fromFirestore(Map<String, dynamic> data) {
    return IncomeItem(
      category: IncomeCategory.fromString(data['categoryName']),
      amount: data['amount'] ?? '0',
      note: data['note'] ?? 'unknown',
      timestamp: data['timestamp'] != null
          ? (data['timestamp'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}

enum IncomeCategory {
  salary(FontAwesomeIcons.moneyBill, 'Salary'),
  investment(FontAwesomeIcons.chartBar, 'Investment'),
  partTime(FontAwesomeIcons.clock, 'Part Time'),
  addNew(FontAwesomeIcons.plus, 'Add New'),
  unknown(FontAwesomeIcons.question, 'Unknown');

  final IconData icon;
  final String label;
  const IncomeCategory(this.icon, this.label);

  static IncomeCategory fromString(String? name) {
    return IncomeCategory.values.firstWhere(
      (e) => e.name.toLowerCase() == name?.toLowerCase(),
      orElse: () => IncomeCategory.unknown,
    );
  }
}
