import 'dart:async';
import 'package:budget_pro/data/models/expense_item.dart';
import 'package:budget_pro/data/models/income_item.dart';
import 'package:budget_pro/domain/expense_repository.dart';
import 'package:budget_pro/domain/income_repository.dart';
import 'package:flutter/material.dart';

class CalculateTotalIncomeExpense extends ChangeNotifier {
  final IncomeRepository _incomeRepository = IncomeRepository();
  late StreamSubscription<List<IncomeItem>> _incomeSubscription;
  final ExpenseRepository _expenseRepository = ExpenseRepository();
  late StreamSubscription<List<ExpenseItem>> _expenseSubscription;

  Future<int> calculateTotalIncome() async {
    int total = 0;
    final completer = Completer<int>();

    _incomeSubscription = _incomeRepository.getData().listen(
      (data) {
        for (Object el in data) {
          final income = el as IncomeItem;
          int? amount = int.tryParse(income.amount);
          total += amount ?? 0;
        }

        if (!completer.isCompleted) {
          completer.complete(total);
        }
      },
      onError: (e) {
        completer.completeError(e);
      },
    );

    return completer.future;
  }

  Future<int> calculateTotalExpense() async {
    int total = 0;
    final completer = Completer<int>();

    _expenseSubscription = _expenseRepository.getData().listen(
      (data) {
        for (Object el in data) {
          final expense = el as ExpenseItem;
          int? amount = int.tryParse(expense.amount);
          total += amount ?? 0;
        }

        if (!completer.isCompleted) {
          completer.complete(total);
        }
      },
      onError: (e) {
        completer.completeError(e);
      },
    );

    return completer.future;
  }

  @override
  void dispose() {
    _incomeSubscription.cancel();
    _expenseSubscription.cancel();
    super.dispose();
  }
}
