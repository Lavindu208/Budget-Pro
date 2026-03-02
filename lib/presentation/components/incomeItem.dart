import 'package:budget_pro/presentation/appColors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget incomeItem() {
  return Column(
    children: [
      Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: AppColors.boxGreen,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Icon(
                    FontAwesomeIcons.moneyBillWave,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                'salary',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Spacer(),
          Text(
            '250.00',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      SizedBox(height: 15),
    ],
  );
}
