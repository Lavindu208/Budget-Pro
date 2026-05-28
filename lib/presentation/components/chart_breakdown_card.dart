import 'package:budget_pro/presentation/appColors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Container chartBreakDownCard(String category, int amount, double percentage) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(17, 0, 0, 0),
          offset: Offset(0, 4),
          blurRadius: 10,
          spreadRadius: 1,
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 55,
              height: 55,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(104, 240, 89, 89),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                FontAwesomeIcons.utensils,
                size: 28,
                color: AppColors.boxRed,
              ),
            ),
            // SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    category,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ),
                // SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  height: 25,
                  child: LinearPercentIndicator(
                    animation: true,
                    curve: Curves.easeOut,
                    animationDuration: 1000,
                    lineHeight: 8,
                    percent: 0.4,
                    backgroundColor: const Color.fromARGB(255, 233, 233, 233),
                    progressColor: AppColors.boxRed,
                    barRadius: Radius.circular(10),
                    trailing: Text(
                      '$percentage%',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        Text(
          '$amount.00 LKR',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Saira',
          ),
        ),
      ],
    ),
  );
}
