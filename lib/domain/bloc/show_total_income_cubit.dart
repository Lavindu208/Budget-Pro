import 'dart:async';
import 'package:budget_pro/domain/calculate_total_income_expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowTotalIncomeCubit extends Cubit<int> {
  final CalculateTotalIncomeExpense _calculateTotalIncomeExpense =
      CalculateTotalIncomeExpense();
  ShowTotalIncomeCubit() : super(0);

  Future<void> showTotalIncome() async {
    int totalIncome = await _calculateTotalIncomeExpense.calculateTotalIncome();
    emit(totalIncome);
  }
}
