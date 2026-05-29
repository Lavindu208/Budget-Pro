import 'dart:async';

import 'package:budget_pro/domain/bloc/show_details_on_expense_chart_cubit.dart';
import 'package:budget_pro/domain/calculate_income_chart_data.dart';
import 'package:budget_pro/domain/income_repository.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class IncomeDataState {}

class IncomeDataInit extends IncomeDataState {}

class IncomeDataLoading extends IncomeDataState {}

class IncomeDataLoaded extends IncomeDataState {
  final List<Map<String, dynamic>> chartDataList;
  IncomeDataLoaded(this.chartDataList);
}

class IncomeDataEmpty extends IncomeDataState {
  final String message;
  IncomeDataEmpty(this.message);
}

class IncomeDataError extends IncomeDataState {
  final String message;
  IncomeDataError(this.message);
}

class ShowDetailsOnIncomeChartCubit extends Cubit<IncomeDataState> {
  final ShowDetailsOnExpenseChartCubit expenseChartCubit;
  final IncomeChartDataCalculator _incomeChartDataCalculator =
      IncomeChartDataCalculator();
  final IncomeRepository _incomeRepository = IncomeRepository();
  late final ChartDataService _chartDataService = ChartDataService(
    _incomeRepository,
    _incomeChartDataCalculator,
  );
  late final StreamSubscription<DataState> expenseSubscription;
  ShowDetailsOnIncomeChartCubit({required this.expenseChartCubit})
    : super(IncomeDataInit()) {
    displayDetails(expenseChartCubit.state);

    expenseSubscription = expenseChartCubit.stream.listen((expenseState) {
      displayDetails(expenseState);
    });
  }
  @override
  Future<void> close() {
    expenseSubscription.cancel();
    return super.close();
  }

  void displayDetails(DataState expenseDataState) async {
    if (expenseDataState is DataLoaded || expenseDataState is DataEmpty) {
      try {
        List<Map<String, dynamic>> chartDataList = await _chartDataService
            .getChartData();
        if (chartDataList.length < 2) {
          emit(IncomeDataEmpty("Add more expenses to see chart analytics"));
        } else {
          emit(IncomeDataLoaded(chartDataList));
        }
      } catch (e) {
        debugPrint("error occurred while loading income chart data : $e");
      }
    } else {
      emit(IncomeDataLoading());
    }
  }
}
