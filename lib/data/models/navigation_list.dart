import 'package:budget_pro/presentation/screens/charts.dart';
import 'package:budget_pro/presentation/screens/expenses.dart';
import 'package:budget_pro/presentation/screens/home.dart';
import 'package:budget_pro/presentation/screens/profile.dart';
import 'package:flutter/material.dart';

class NavigationList {
  static List<String> titles = ['Home', 'Cashflow', 'Charts', 'Profile'];
  static const List<Widget> screens = [Home(), Expenses(), Charts(), Profile()];
}
