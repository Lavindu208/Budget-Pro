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
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Add Income"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
