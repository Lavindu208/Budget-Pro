import 'package:budget_pro/presentation/appColors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget expenseItem(
  IconData icon,
  String itemName,
  String amount,
  bool isSelectedItem,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    color: isSelectedItem
        ? const Color.fromARGB(255, 241, 241, 241)
        : Colors.transparent,
    child: Column(
      children: [
        Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.boxGreen,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Icon(icon, size: 20, color: Colors.white),
                      ),
                    ),
                    isSelectedItem
                        ? Positioned(
                            bottom: 0,
                            right: 0,
                            child: Stack(
                              children: [
                                Container(
                                  width: 19,
                                  height: 19,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                Icon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  size: 19,
                                  color: AppColors.navigatorColor,
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
                SizedBox(width: 10),
                Text(
                  itemName,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Spacer(),
            Text(
              '$amount.00',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    ),
  );
}
