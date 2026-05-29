import 'package:budget_pro/data/models/expense_item.dart';
import 'package:budget_pro/domain/expense_repository.dart';
import 'package:budget_pro/presentation/appColors/app_colors.dart';
import 'package:flutter/material.dart';

class ChartDataService {
  final ExpenseRepository _expenseRepository;
  final ExpenseChartDataCalculator _chartDataCalculator;

  ChartDataService(this._expenseRepository, this._chartDataCalculator);

  Future<List<Map<String, dynamic>>> getChartData() async {
    final expenseList = await _expenseRepository.getData().first;
    List<ExpenseItem> expenses = List.from(expenseList);
    List<Color> colorList = ChartColors.chartColorList;

    final totalOfEachCategory = _chartDataCalculator
        .calcTotalAmountOfEachCategory(expenses);
    final sortedExpensesList = _chartDataCalculator
        .sortExpenseListInAscendingOrder(totalOfEachCategory);
    final selectedExpenseList = sortedExpensesList.sublist(0, 5);
    final finalSelectedExpenseList = _chartDataCalculator
        .removeUnnecessaryExpenses(selectedExpenseList);
    final totalAmount = _chartDataCalculator.calcTotalAmount(
      finalSelectedExpenseList,
    );
    final chartItemsWithPercentage = _chartDataCalculator
        .calcPercentageOfEachCategory(totalAmount, finalSelectedExpenseList);
    final chartExpenseList = _chartDataCalculator.makeFinalChartExpenseList(
      chartItemsWithPercentage,
      colorList,
    );
    return chartExpenseList;
  }
}

class ExpenseChartDataCalculator {
  List<Map<String, dynamic>> sortExpenseListInAscendingOrder(
    List<Map<String, dynamic>> localExpenses,
  ) {
    localExpenses.sort((a, b) {
      int aAmount = int.tryParse(a['amount']?.toString() ?? '') ?? 0;
      int bAmount = int.tryParse(b['amount']?.toString() ?? '') ?? 0;
      return bAmount.compareTo(aAmount);
    });

    return localExpenses;
  }

  List<Map<String, dynamic>> calcTotalAmountOfEachCategory(
    List<ExpenseItem> expenses,
  ) {
    int total;
    List<Map<String, dynamic>> totalAmountOfCategory = [];
    for (ExpenseCategory category in ExpenseCategory.values) {
      total = 0;
      for (ExpenseItem expense in expenses) {
        if (expense.category.label.toLowerCase() ==
            category.name.toLowerCase()) {
          total += int.parse(expense.amount);
        }
      }
      totalAmountOfCategory.add({'category': category.label, 'amount': total});
    }
    return totalAmountOfCategory;
  }

  int calcTotalAmount(List<Map<String, dynamic>> expenseList) {
    int total = 0;
    for (Map item in expenseList) {
      total += int.tryParse(item['amount']?.toString() ?? '') ?? 0;
    }

    return total;
  }

  List<Map<String, dynamic>> removeUnnecessaryExpenses(
    List<Map<String, dynamic>> selectedList,
  ) {
    List<Map<String, dynamic>> filteredExpenses = [];
    for (Map item in selectedList) {
      int amount = int.tryParse(item['amount'].toString()) ?? 0;
      if (amount != 0) {
        filteredExpenses.add(item as Map<String, dynamic>);
      } else {
        break;
      }
    }
    return filteredExpenses;
  }

  List<Map<String, dynamic>> calcPercentageOfEachCategory(
    int total,
    List<Map<String, dynamic>> selectedExpenseList,
  ) {
    double percentage = 0;
    for (Map item in selectedExpenseList) {
      percentage =
          ((100 / total) *
                  (double.tryParse(item['amount']?.toString() ?? '') ?? 0))
              .floorToDouble();
      item['percentage'] = percentage;
    }

    return selectedExpenseList;
  }

  List<Map<String, dynamic>> makeFinalChartExpenseList(
    List<Map<String, dynamic>> expenseList,
    List<Color> chartColorList,
  ) {
    int i = 0;
    for (Map item in expenseList) {
      item['color'] = chartColorList[i];
      i++;
    }

    return expenseList;
  }
}
