import 'package:budget_pro/domain/bloc/add_new_expense_bloc.dart';
import 'package:budget_pro/domain/bloc/add_new_income_bloc.dart';
import 'package:budget_pro/domain/bloc/show_total_expense_cubit.dart';
import 'package:budget_pro/domain/bloc/show_total_income_cubit.dart';
import 'package:budget_pro/domain/bloc/display_category_cubit.dart';
import 'package:budget_pro/presentation/appColors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomNumpad extends StatefulWidget {
  final String previousRoute;
  const CustomNumpad({super.key, required this.previousRoute});

  @override
  State<CustomNumpad> createState() => _CustomNumpad();
}

class _CustomNumpad extends State<CustomNumpad> {
  List<String> keys = [
    '7',
    '8',
    '9',
    '4',
    '5',
    '6',
    '1',
    '2',
    '3',
    '.',
    '0',
    'Del',
  ];
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Container(
                    alignment: Alignment.center,
                    width: 120,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.boxGreen,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: BlocBuilder<DisplayCategoryCubit, String>(
                      builder: (context, categoryName) {
                        return Text(
                          categoryName,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 58, 58, 58),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: TextField(
                          readOnly: true,
                          showCursor: true,
                          controller: _pinController,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          decoration: InputDecoration(
                            hint: Text(
                              'Enter amount here...',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 192, 192, 192),
                                fontSize: 15,
                              ),
                            ),

                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        if (widget.previousRoute == '/addExpense') {
                          context.read<AddNewExpenseBloc>().add(
                            AddNewExpenseItem(
                              context.read<DisplayCategoryCubit>().state,
                              _pinController.text.trim(),
                              FontAwesomeIcons.brandsFontAwesome,
                              context,
                            ),
                          );
                          context
                              .read<ShowTotalExpenseCubit>()
                              .showTotalExpense();
                        } else {
                          context.read<AddNewIncomeBloc>().add(
                            AddNewIncomeItem(
                              categoryName: context
                                  .read<DisplayCategoryCubit>()
                                  .state,
                              amount: _pinController.text.trim(),
                              icon: FontAwesomeIcons.brandsFontAwesome,
                            ),
                          );
                          context
                              .read<ShowTotalIncomeCubit>()
                              .showTotalIncome();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 43, 43, 43),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          FontAwesomeIcons.plus,
                          size: 23,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 340,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    childAspectRatio: 2.0,
                    mainAxisSpacing: 8,
                    physics: const NeverScrollableScrollPhysics(),
                    children: keys.map((key) {
                      return InkWell(
                        onTap: () {
                          _handleKeyPress(key);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 73, 73, 73),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: key == 'Del'
                              ? Icon(
                                  FontAwesomeIcons.deleteLeft,
                                  color: Colors.white,
                                )
                              : Text(
                                  key,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleKeyPress(String val) {
    if (val == 'Del') {
      if (_pinController.text.isNotEmpty) {
        _pinController.text = _pinController.text.substring(
          0,
          _pinController.text.length - 1,
        );
      }
    } else {
      _pinController.text += val;
    }
  }
}
