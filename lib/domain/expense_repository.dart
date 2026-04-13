import 'package:budget_pro/data/models/expense_item.dart';
import 'package:budget_pro/domain/authentication/auth_repository.dart';
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
        // .orderBy('date', descending: true)
        .doc(uid)
        .collection('expenses')
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

  List<String> filterItemsToDelete(
    List<Map<String, dynamic>> docIdsWithTimestamp,
    List<int> selectedItems,
  ) {
    List<String> docIds = [];

    for (int index in selectedItems) {
      docIds.add(docIdsWithTimestamp[index]['id']);
    }

    return docIds;
  }

  Future<List<Map<String, dynamic>>> getDocIdWithServerTimestamp(
    String uid,
    String collectionPath,
  ) async {
    final snapshot = await _db
        .collection('users')
        .doc(uid)
        .collection(collectionPath)
        .get();

    List<Map<String, dynamic>> docIdsWithTimestamp = snapshot.docs.map((doc) {
      final data = doc.data();
      return {'id': doc.id, 'serverTimestamp': data['timestamp']};
    }).toList();

    return docIdsWithTimestamp;
  }

  Future<void> deleteData(
    String collectionPath,
    List<int> selectedItems,
  ) async {
    // get the user id from auth repository
    String uid = AuthRepository().auth.currentUser!.uid;
    List<Map<String, dynamic>> docIdsWithTimestamp =
        await getDocIdWithServerTimestamp(uid, collectionPath);

    List<String> docIds = filterItemsToDelete(
      docIdsWithTimestamp,
      selectedItems,
    );
    final batch = FirebaseFirestore.instance.batch();
    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection(collectionPath);
    try {
      for (String id in docIds) {
        batch.delete(collection.doc(id));
        debugPrint("Item id : $id");
      }

      await batch.commit();
    } catch (e) {
      debugPrint("Error deleting data : $e");
    }
  }
}
