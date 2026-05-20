import 'package:budget_pro/data/models/income_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IncomeRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _collectionName = 'income';

  Future<void> addData(String categoryName, String amount, String note) async {
    String? uid = _auth.currentUser?.uid;
    Map<String, dynamic> incomeData = {
      'categoryName': categoryName,
      'amount': amount,
      'note': note,
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection(_collectionName)
          .add(incomeData);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<List<IncomeItem>> getData() {
    String? uid = _auth.currentUser?.uid;
    return _db
        .collection('users')
        .doc(uid)
        .collection(_collectionName)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return IncomeItem.fromFirestore(doc.data());
          }).toList();
        });
  }
}
