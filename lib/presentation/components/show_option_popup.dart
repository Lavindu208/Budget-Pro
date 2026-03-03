import 'package:budget_pro/domain/routes/routes.dart';
import 'package:flutter/material.dart';

void showOptionPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Select an Option"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("Add Expense"),
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.addExpense);
              },
            ),
            ListTile(
              title: Text("Add Income"),
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.addIncome);
              },
            ),
          ],
        ),
      );
    },
  );
}
