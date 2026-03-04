import 'package:budget_pro/domain/bloc/bottomNavigator/navigator_event.dart';
import 'package:budget_pro/domain/routes/routes.dart';
import 'package:budget_pro/presentation/components/show_option_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckScreen {
  static int tabIndex = 0;
  void checkScreen(BuildContext context) {
    int currentPage = context.read<NavigatorCubit>().state;
    if (currentPage != 1) {
      showOptionPopup(context);
    } else if (currentPage == 1 && tabIndex == 0) {
      Navigator.pushNamed(context, AppRoutes.addExpense);
    } else if (currentPage == 1 && tabIndex == 1) {
      Navigator.pushNamed(context, AppRoutes.addIncome);
    }
  }
}
