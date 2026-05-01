import 'dart:async';
import 'package:budget_pro/domain/calculate_total_income_expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowTotalExpenseCubit extends Cubit<int> {
  final CalculateTotalIncomeExpense _calculateTotalIncomeExpense =
      CalculateTotalIncomeExpense();
  ShowTotalExpenseCubit() : super(0);

  Future<void> showTotalExpense() async {
    int totalExpense = await _calculateTotalIncomeExpense
        .calculateTotalExpense();
    emit(totalExpense);
  }
}
