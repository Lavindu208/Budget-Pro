import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpenseItem {
  final ExpenseCategory category;
  String amount;
  String note;
  DateTime timestamp;

  ExpenseItem({
    required this.category,
    required this.amount,
    required this.note,
    required this.timestamp,
  });

  factory ExpenseItem.fromFirestore(Map<String, dynamic> data) {
    return ExpenseItem(
      category: ExpenseCategory.fromString(data['categoryName']),
      amount: data['amount'] ?? '0',
      note: data['note'] ?? 'unknown',
      timestamp: data['timestamp'] != null
          ? (data['timestamp'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}

class HomeScreenExpenses {
  static List<ExpenseItem>? homeScreenExpenseItems;

  HomeScreenExpenses({List? homeScreenExpenseItems});
}

enum ExpenseCategory {
  food(FontAwesomeIcons.burger, 'Food'),
  education(FontAwesomeIcons.graduationCap, 'Education'),
  entertainment(FontAwesomeIcons.headset, 'entertainment'),
  transportation(FontAwesomeIcons.car, 'Transportation'),
  vehicle(FontAwesomeIcons.motorcycle, 'Vehicle'),
  electronics(FontAwesomeIcons.microchip, 'Electronics'),
  travel(FontAwesomeIcons.plane, 'Travel'),
  clothing(FontAwesomeIcons.shirt, 'Clothing'),
  donation(FontAwesomeIcons.circleDollarToSlot, 'Donation'),
  repair(FontAwesomeIcons.screwdriverWrench, 'Repair'),
  gift(FontAwesomeIcons.gift, 'Gift'),
  sports(FontAwesomeIcons.personSwimming, 'Sports'),
  home(FontAwesomeIcons.house, 'Home'),
  rental(FontAwesomeIcons.key, 'Rental'),
  shopping(FontAwesomeIcons.bagShopping, 'Shopping'),
  addNew(FontAwesomeIcons.plus, 'Add New'),
  unknown(FontAwesomeIcons.question, 'Unknown');

  final IconData icon;
  final String label;
  const ExpenseCategory(this.icon, this.label);

  static ExpenseCategory fromString(String? name) {
    return ExpenseCategory.values.firstWhere(
      (e) => e.name.toLowerCase() == name?.toLowerCase(),
      orElse: () => ExpenseCategory.unknown,
    );
  }
}
