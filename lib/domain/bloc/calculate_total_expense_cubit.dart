import 'package:budget_pro/data/models/expense_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculateTotalExpenseCubit extends Cubit<int> {
  CalculateTotalExpenseCubit({required List<ExpenseItem> expensesList})
    : super(calculateTotal(expensesList));

  static int calculateTotal(List<ExpenseItem> expensesList) {
    int total = 0;
    for (Object el in expensesList) {
      final expenses = el as ExpenseItem;
      int? amount = int.tryParse(expenses.amount);
      total += amount!;
    }
    return total;
  }
}
