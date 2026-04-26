import 'package:budget_pro/domain/authentication/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteExpenseIncomeItems {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<String> filterItemsToDelete(
    List<Map<String, dynamic>> docIdsWithTimestamp,
    List<DateTime> selectedItems,
  ) {
    List<String> docIds = [];

    for (DateTime timestamp in selectedItems) {
      for (Map item in docIdsWithTimestamp) {
        if (timestamp.isAtSameMomentAs(item['serverTimestamp'])) {
          docIds.add(item['id']);
        }
      }
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
      return {
        'id': doc.id,
        'serverTimestamp': (data['timestamp'] as Timestamp).toDate(),
      };
    }).toList();

    return docIdsWithTimestamp;
  }

  Future<bool> deleteData(
    String collectionPath,
    List<DateTime> selectedItems,
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
      }
      await batch.commit();
      return true;
    } catch (e) {
      debugPrint("Error deleting data : $e");
    }
    return false;
  }
}
