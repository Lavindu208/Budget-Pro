import 'package:budget_pro/domain/bloc/show_total_expense_cubit.dart';
import 'package:budget_pro/domain/bloc/show_total_income_cubit.dart';
import 'package:budget_pro/presentation/appColors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget twoBoxes(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.boxRed,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              // Optional: Adds a subtle shadow for depth
              BoxShadow(
                color: const Color.fromARGB(66, 0, 0, 0),
                blurRadius: 12,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<ShowTotalExpenseCubit, int>(
                    builder: (context, state) {
                      return Text(
                        '-$state.00',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 5),
                  Text(
                    'LKR',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Total Expenses',
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      SizedBox(width: 10),
      SizedBox(width: 10),
      Expanded(
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.boxGreen,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              // Optional: Adds a subtle shadow for depth
              BoxShadow(
                color: const Color.fromARGB(66, 0, 0, 0),
                blurRadius: 12,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<ShowTotalIncomeCubit, int>(
                      builder: (context, state) {
                        return Text(
                          '+$state.00',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 5),
                    Text(
                      'LKR',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Total Income',
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
