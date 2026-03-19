import 'package:budget_pro/data/models/income_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class IncomeRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _collectionName = 'income';

  Future<void> addData(String categoryName, String amount) async {
    Map<String, dynamic> incomeData = {
      'categoryName': categoryName,
      'amount': amount,
      'date': _calculateDate(),
    };

    try {
      await _db.collection(_collectionName).add(incomeData);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  DateTime _calculateDate() {
    return DateTime.now();
  }

  Stream<List<IncomeItem>> getData() {
    return _db
        .collection(_collectionName)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((docs) {
            final data = docs.data();
            return IncomeItem(
              icon: FontAwesomeIcons.addressBook,
              categoryName: data['categoryName'],
              amount: data['amount'],
            );
          }).toList();
        });
  }
}
