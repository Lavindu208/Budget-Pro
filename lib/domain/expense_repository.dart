import 'package:budget_pro/data/models/expense_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpenseRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<void> addData(String categoryName, String amount) async {
    Map<String, dynamic> expenseData = {
      'categoryName': categoryName,
      'amount': amount,
      'date': _calculateDate(),
    };

    try {
      await db.collection("expenses").add(expenseData);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  DateTime _calculateDate() {
    return DateTime.now();
  }

  Stream<List<ExpenseItem>> getData() {
    return db
        .collection('expenses')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return ExpenseItem(
              icon: FontAwesomeIcons.addressCard,
              categoryName: data['categoryName'],
              amount: data['amount'],
            );
          }).toList();
        });
  }
}
