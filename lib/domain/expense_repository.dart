import 'package:budget_pro/data/models/expense_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpenseRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> addData(String categoryName, String amount) async {
    final String? uid = _auth.currentUser?.uid;
    Map<String, dynamic> expenseData = {
      'categoryName': categoryName,
      'amount': amount,
      'date': _calculateDate(),
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('expenses')
          .add(expenseData);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  DateTime _calculateDate() {
    return DateTime.now();
  }

  Stream<List<ExpenseItem>> getData() {
    final String? uid = _auth.currentUser?.uid;
    if (uid == null) {
      return const Stream.empty();
    }
    return _db
        .collection('users')
        .doc(uid)
        .collection('expenses')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return ExpenseItem(
              icon: FontAwesomeIcons.addressCard,
              categoryName: data['categoryName'] ?? 'Unknown',
              amount: data['amount'] ?? '0',
              timestamp: data['timestamp'] != null
                  ? (data['timestamp'] as Timestamp).toDate()
                  : DateTime.now(),
            );
          }).toList();
        });
  }
}
