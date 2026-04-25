import 'dart:async';
import 'package:budget_pro/data/models/expense_item.dart';
import 'package:budget_pro/domain/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculateTotalExpenseCubit extends Cubit<int> {
  final ExpenseRepository _expenseRepository = ExpenseRepository();
  late StreamSubscription<List<ExpenseItem>> _subscription;
  CalculateTotalExpenseCubit({required List<ExpenseItem> expensesList})
    : super(calculateInitTotal(expensesList));
  static int calculateInitTotal(List<ExpenseItem> expensesList) {
    int total = 0;
    for (Object el in expensesList) {
      final expenses = el as ExpenseItem;
      int? amount = int.tryParse(expenses.amount);
      total += amount!;
    }
    return total;
  }

  void calculateTotal() {
    _subscription = _expenseRepository.getData().listen((data) {
      int total = 0;
      for (Object el in data) {
        final expenses = el as ExpenseItem;
        int? amount = int.tryParse(expenses.amount);
        total += amount!;
      }
      emit(total);
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
