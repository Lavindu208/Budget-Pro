import 'package:budget_pro/domain/calculate_chart_data.dart';
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

class DataError extends DataState {
  final String message;
  DataError(this.message);
}

class ShowDetailsOnChartCubit extends Cubit<DataState> {
  final ChartDataCalculator _chartDataCalculator = ChartDataCalculator();
  final ExpenseRepository _expenseRepository = ExpenseRepository();
  late final ChartDataService _chartDataService = ChartDataService(
    _expenseRepository,
    _chartDataCalculator,
  );
  ShowDetailsOnChartCubit() : super(DataInit());
  void displayDetails() async {
    try {
      List<Map<String, dynamic>> chartDataList = await _chartDataService
          .getChartData();
      emit(DataLoaded(chartDataList));
    } catch (e) {
      debugPrint("error occurred while loading chart data");
    }
  }
}
