import 'package:budget_pro/domain/bloc/bottomNavigator/navigator_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowSelectOption extends Cubit<bool> {
  ShowSelectOption() : super(false);
  void showOption(BuildContext context) {
    int currentPage = context.read<NavigatorCubit>().state;

    if (currentPage == 0) {
      emit(!state);
    }
  }
}
