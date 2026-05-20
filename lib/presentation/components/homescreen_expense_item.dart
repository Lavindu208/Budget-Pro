import 'package:flutter/material.dart';

Column homeScreenExpenseItem(IconData icon, String category, String amount) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 252, 252, 255),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: const Color.fromARGB(48, 52, 246, 38),
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 22,
                color: const Color.fromARGB(255, 62, 201, 41),
              ),
            ),
            SizedBox(width: 10),
            Text(category, style: TextStyle(fontSize: 16)),
            Spacer(),
            Text(
              '-$amount.00',
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(255, 211, 45, 33),
                fontFamily: 'Saira',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 10),
    ],
  );
}
