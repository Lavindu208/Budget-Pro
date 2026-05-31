import 'package:budget_pro/data/models/income_item.dart';
import 'package:budget_pro/domain/income_repository.dart';
import 'package:budget_pro/presentation/appColors/app_colors.dart';
import 'package:flutter/material.dart';

class ChartDataService {
  final IncomeRepository _incomeRepository;
  final IncomeChartDataCalculator _incomeChartDataCalculator;

  ChartDataService(this._incomeRepository, this._incomeChartDataCalculator);

  Future<List<Map<String, dynamic>>> getChartData() async {
    final incomeList = await _incomeRepository.getData().first;
    List<IncomeItem> incomes = List.from(incomeList);
    // for (IncomeItem item in incomes) {
    //   debugPrint("amount : ${item.amount}\ncategory : ${item.category}");
    // }
    List<Color> colorList = ChartColors.chartColorList;

    final totalOfEachCategory = _incomeChartDataCalculator
        .calcTotalAmountOfEachCategory(incomes);
    debugPrint("total : $totalOfEachCategory");
    final sortedIncomeList = _incomeChartDataCalculator
        .sortExpenseListInAscendingOrder(totalOfEachCategory);
    final selectedIncomeList = sortedIncomeList.sublist(0, 5);
    debugPrint("selected income list : $selectedIncomeList");
    final finalSelectedIncomeList = _incomeChartDataCalculator
        .removeUnnecessaryExpenses(selectedIncomeList);
    final totalAmount = _incomeChartDataCalculator.calcTotalAmount(
      finalSelectedIncomeList,
    );
    final chartItemsWithPercentage = _incomeChartDataCalculator
        .calcPercentageOfEachCategory(totalAmount, finalSelectedIncomeList);
    final chartIncomeList = _incomeChartDataCalculator
        .makeFinalChartExpenseList(chartItemsWithPercentage, colorList);
    return chartIncomeList;
  }
}

class IncomeChartDataCalculator {
  List<Map<String, dynamic>> sortExpenseListInAscendingOrder(
    List<Map<String, dynamic>> localIncomes,
  ) {
    localIncomes.sort((a, b) {
      int aAmount = int.tryParse(a['amount']?.toString() ?? '') ?? 0;
      int bAmount = int.tryParse(b['amount']?.toString() ?? '') ?? 0;
      return bAmount.compareTo(aAmount);
    });

    return localIncomes;
  }

  List<Map<String, dynamic>> calcTotalAmountOfEachCategory(
    List<IncomeItem> incomes,
  ) {
    int total;
    List<Map<String, dynamic>> totalAmountOfCategory = [];
    for (IncomeCategory category in IncomeCategory.values) {
      total = 0;
      for (IncomeItem income in incomes) {
        if (income.category.label.toLowerCase() ==
            category.name.toLowerCase()) {
          total += int.parse(income.amount);
        }
      }
      totalAmountOfCategory.add({'category': category.label, 'amount': total});
    }
    return totalAmountOfCategory;
  }

  int calcTotalAmount(List<Map<String, dynamic>> incomeList) {
    int total = 0;
    for (Map item in incomeList) {
      total += int.tryParse(item['amount']?.toString() ?? '') ?? 0;
    }

    return total;
  }

  List<Map<String, dynamic>> removeUnnecessaryExpenses(
    List<Map<String, dynamic>> selectedList,
  ) {
    List<Map<String, dynamic>> filteredIncomes = [];
    for (Map item in selectedList) {
      int amount = int.tryParse(item['amount'].toString()) ?? 0;
      if (amount != 0) {
        filteredIncomes.add(item as Map<String, dynamic>);
      } else {
        break;
      }
    }
    return filteredIncomes;
  }

  List<Map<String, dynamic>> calcPercentageOfEachCategory(
    int total,
    List<Map<String, dynamic>> selectedIncomeList,
  ) {
    double percentage = 0;
    for (Map item in selectedIncomeList) {
      percentage =
          ((100 / total) *
                  (double.tryParse(item['amount']?.toString() ?? '') ?? 0))
              .floorToDouble();
      item['percentage'] = percentage;
    }

    return selectedIncomeList;
  }

  List<Map<String, dynamic>> makeFinalChartExpenseList(
    List<Map<String, dynamic>> incomeList,
    List<Color> chartColorList,
  ) {
    int i = 0;
    for (Map item in incomeList) {
      item['color'] = chartColorList[i];
      i++;
    }

    return incomeList;
  }
}
