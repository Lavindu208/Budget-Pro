import 'package:cloud_firestore/cloud_firestore.dart';

class UploadExpenseData {
  String categoryName;
  String amount;

  UploadExpenseData(this.categoryName, this.amount);

  void addData() async {
    Map<String, dynamic> expenseData = {
      'categoryName': categoryName,
      'amount': amount,
    };
    FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      await db.collection("expenses").add(expenseData);
    } catch (e) {
      print(e);
    }
  }
}
