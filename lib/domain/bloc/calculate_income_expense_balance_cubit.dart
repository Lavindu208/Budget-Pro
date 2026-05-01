import 'package:budget_pro/domain/calculate_total_income_expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculateIncomeExpenseBalanceCubit extends Cubit<int> {
  CalculateIncomeExpenseBalanceCubit() : super(0);
  final CalculateTotalIncomeExpense _calculateTotalIncomeExpense =
      CalculateTotalIncomeExpense();
  Future<void> calculateBalance() async {
    int totalIncome = await _calculateTotalIncomeExpense.calculateTotalIncome();
    int totalExpense = await _calculateTotalIncomeExpense
        .calculateTotalExpense();
    int balance = totalIncome - totalExpense;
    emit(balance);
  }
}
