import 'package:budget_pro/data/models/expense_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExpenseRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> addData(String categoryName, String amount, String note) async {
    final String? uid = _auth.currentUser?.uid;
    Map<String, dynamic> expenseData = {
      'categoryName': categoryName,
      'amount': amount,
      'note': note,
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

  Stream<List<ExpenseItem>> getData() {
    final String? uid = _auth.currentUser?.uid;
    if (uid == null) {
      return const Stream.empty();
    }
    return _db
        .collection('users')
        .doc(uid)
        .collection('expenses')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return ExpenseItem.fromFirestore(doc.data());
          }).toList();
        });
  }
}
