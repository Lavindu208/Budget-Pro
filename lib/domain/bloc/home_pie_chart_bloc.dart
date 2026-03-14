import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateHomePieChart {
  Color sectionColor;
  String categoryName;
  String percentage;

  UpdateHomePieChart(this.categoryName, this.percentage, this.sectionColor);
}

class HomePieChartBloc extends Bloc<UpdateHomePieChart, List> {
  HomePieChartBloc() : super([]) {
    on<UpdateHomePieChart>((event, emit) {});
  }
}
