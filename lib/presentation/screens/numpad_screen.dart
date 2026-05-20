import 'package:budget_pro/domain/bloc/add_new_expense_bloc.dart';
import 'package:budget_pro/domain/bloc/add_new_income_bloc.dart';
import 'package:budget_pro/domain/bloc/display_category_cubit.dart';
import 'package:budget_pro/domain/bloc/show_total_expense_cubit.dart';
import 'package:budget_pro/domain/bloc/show_total_income_cubit.dart';
import 'package:flutter/material.dart';
import 'package:budget_pro/presentation/components/custom_numpad.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NumpadScreen extends StatefulWidget {
  final String previousRoute;
  const NumpadScreen({super.key, required this.previousRoute});

  @override
  State<NumpadScreen> createState() => _NumpadScreenState();
}

class _NumpadScreenState extends State<NumpadScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final FocusNode _amountFocus = FocusNode();
  final FocusNode _noteFocus = FocusNode();

  bool _isNumpadOpen = true;

  @override
  void initState() {
    super.initState();

    _amountFocus.addListener(() {
      if (_amountFocus.hasFocus) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted && _amountFocus.hasFocus) {
            setState(() {
              _isNumpadOpen = true;
            });
          }
        });
      }
    });

    _noteFocus.addListener(() {
      if (_noteFocus.hasFocus) {
        setState(() {
          _isNumpadOpen = false;
        });
      }
    });
  }

  void _onNumberSelected(String number) {
    _amountController.text += number;
  }

  void _onBackPress() {
    if (_amountController.text.isNotEmpty) {
      _amountController.text = _amountController.text.substring(
        0,
        _amountController.text.length - 1,
      );
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _amountFocus.dispose();
    _noteFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextField(
                          controller: _amountController,
                          focusNode: _amountFocus,
                          readOnly: true,
                          showCursor: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Amount...',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 192, 192, 192),
                              fontSize: 15,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                        const Divider(
                          color: Color.fromARGB(255, 118, 118, 118),
                        ),
                        TextField(
                          controller: _noteController,
                          focusNode: _noteFocus,
                          readOnly: false,
                          showCursor: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Note...',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 192, 192, 192),
                              fontSize: 15,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      fixedSize: const Size(70, 90),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      if (widget.previousRoute == '/addExpense') {
                        debugPrint("route : ${widget.previousRoute}");
                        context.read<AddNewExpenseBloc>().add(
                          AddNewExpenseItem(
                            context.read<DisplayCategoryCubit>().state,
                            _amountController.text.trim(),
                            _noteController.text.trim(),
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
                            amount: _amountController.text.trim(),
                            note: _noteController.text.trim(),
                          ),
                        );
                        context.read<ShowTotalIncomeCubit>().showTotalIncome();
                      }
                    },
                    child: Icon(FontAwesomeIcons.plus),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     if (widget.previousRoute == '/addExpense') {
                  //       debugPrint("route : ${widget.previousRoute}");
                  //       context.read<AddNewExpenseBloc>().add(
                  //         AddNewExpenseItem(
                  //           context.read<DisplayCategoryCubit>().state,
                  //           _amountController.text.trim(),
                  //           _noteController.text.trim(),
                  //           context,
                  //         ),
                  //       );
                  //       context
                  //           .read<ShowTotalExpenseCubit>()
                  //           .showTotalExpense();
                  //     } else {
                  //       context.read<AddNewIncomeBloc>().add(
                  //         AddNewIncomeItem(
                  //           categoryName: context
                  //               .read<DisplayCategoryCubit>()
                  //               .state,
                  //           amount: _amountController.text.trim(),
                  //           note: _noteController.text.trim(),
                  //         ),
                  //       );
                  //       context.read<ShowTotalIncomeCubit>().showTotalIncome();
                  //     }
                  //   },
                  //   child: Container(
                  //     width: 70,
                  //     height: 90,
                  //     decoration: BoxDecoration(
                  //       color: const Color.fromARGB(255, 98, 98, 98),
                  //       borderRadius: BorderRadius.circular(6),
                  //     ),
                  //     child: Icon(
                  //       FontAwesomeIcons.plus,
                  //       size: 20,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),

            if (_isNumpadOpen)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 5,
                  left: 10,
                  right: 10,
                  top: 13,
                ),
                child: CustomNumpad(
                  onNumberSelected: _onNumberSelected,
                  onBackPress: _onBackPress,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
