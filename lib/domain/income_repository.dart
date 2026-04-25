import 'package:budget_pro/data/models/income_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class IncomeRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _collectionName = 'income';

  Future<void> addData(String categoryName, String amount) async {
    String? uid = _auth.currentUser?.uid;
    Map<String, dynamic> incomeData = {
      'categoryName': categoryName,
      'amount': amount,
      'date': _calculateDate(),
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

  DateTime _calculateDate() {
    return DateTime.now();
  }

  Stream<List<IncomeItem>> getData() {
    String? uid = _auth.currentUser?.uid;
    return _db
        .collection('users')
        .doc(uid)
        .collection(_collectionName)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((docs) {
            final data = docs.data();
            return IncomeItem(
              icon: FontAwesomeIcons.addressBook,
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
