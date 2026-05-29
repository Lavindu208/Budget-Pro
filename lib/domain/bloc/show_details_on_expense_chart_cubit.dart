import 'package:budget_pro/domain/calculate_expense_chart_data.dart';
import 'package:budget_pro/domain/expense_repository.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class DataState {}

class DataInit extends DataState {}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  final List<Map<String, dynamic>> chartDataList;
  DataLoaded(this.chartDataList);
}

class DataEmpty extends DataState {
  final String message;
  DataEmpty(this.message);
}

class DataError extends DataState {
  final String message;
  DataError(this.message);
}

class ShowDetailsOnExpenseChartCubit extends Cubit<DataState> {
  final ExpenseChartDataCalculator _chartDataCalculator =
      ExpenseChartDataCalculator();
  final ExpenseRepository _expenseRepository = ExpenseRepository();
  late final ChartDataService _chartDataService = ChartDataService(
    _expenseRepository,
    _chartDataCalculator,
  );
  ShowDetailsOnExpenseChartCubit() : super(DataInit());
  void displayDetails() async {
    try {
      List<Map<String, dynamic>> chartDataList = await _chartDataService
          .getChartData();
      if (chartDataList.length < 2) {
        emit(DataEmpty("Add more expenses to see chart analytics"));
      } else {
        emit(DataLoaded(chartDataList));
      }
    } catch (e) {
      debugPrint("error occurred while loading chart data");
    }
  }
}
