import 'package:budget_pro/data/models/expense_item.dart';
import 'package:budget_pro/domain/expense_repository.dart';
import 'package:flutter/cupertino.dart';

class ChartDataService {
  final ExpenseRepository _expenseRepository;
  final ChartDataCalculator _chartDataCalculator;

  ChartDataService(this._expenseRepository, this._chartDataCalculator);

  Future<List<Map<String, dynamic>>> getChartData() async {
    final expenses = await _expenseRepository.getData().first;

    final totalOfEachCategory = _chartDataCalculator
        .calcTotalAmountOfEachCategory(expenses);
    final sortedExpensesList = _chartDataCalculator
        .sortExpenseListInAscendingOrder(totalOfEachCategory);
    debugPrint("sorted list : $sortedExpensesList");
    final selectedExpenseList = sortedExpensesList.sublist(0, 5);
    debugPrint("Selected expense list : $selectedExpenseList");
    final totalAmount = _chartDataCalculator.calcTotalAmount(
      selectedExpenseList,
    );
    // debugPrint("total amount : $totalAmount");
    final chartExpenseList = _chartDataCalculator.calcPercentageOfEachCategory(
      totalAmount,
      selectedExpenseList,
    );
    // debugPrint("chart expense list : $chartExpenseList");
    return chartExpenseList;
  }
}

class ChartDataCalculator {
  List<Map<String, dynamic>> sortExpenseListInAscendingOrder(
    List<Map<String, dynamic>> expenses,
  ) {
    List<Map<String, dynamic>> localExpenses = List.from(expenses);

    void insertionSortDescending(List<Map<String, dynamic>> list) {
      for (int i = 1; i < list.length; i++) {
        Map<String, dynamic> key = list[i];
        int j = i - 1;

        int currentAmount = int.parse(key['amount']);
        while (j >= 0 && int.parse(list[j]['amount']) < currentAmount) {
          list[j + 1] = list[j];
          j--;
        }
        list[j + 1] = key;
      }
    }

    insertionSortDescending(localExpenses);
    // debugPrint("sorted list : $localExpenses");
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
      totalAmountOfCategory.add({
        'category': category.label.toLowerCase(),
        'amount': total,
      });
    }
    // print("Total amount of each category : $totalAmountOfCategory");
    return totalAmountOfCategory;
  }

  int calcTotalAmount(List<Map<String, dynamic>> expenseList) {
    int total = 0;
    debugPrint("total : $total");
    for (Map item in expenseList) {
      total += int.parse(item['amount']);
    }

    return total;
  }

  List<Map<String, dynamic>> calcPercentageOfEachCategory(
    int total,
    List<Map<String, dynamic>> selectedExpenseList,
  ) {
    double percentage = 0;
    for (Map item in selectedExpenseList) {
      percentage = ((100 / total) * double.parse(item['amount']))
          .floorToDouble();
      item['amount'] = percentage;
    }

    return selectedExpenseList;
  }
}
