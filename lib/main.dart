import 'package:budget_pro/domain/bloc/bottomNavigator/navigator_event.dart';
import 'package:budget_pro/domain/bloc/date_selector.dart';
import 'package:budget_pro/domain/bloc/show_select_option.dart';
import 'package:budget_pro/presentation/screens/charts.dart';
import 'package:budget_pro/presentation/screens/exchanges.dart';
import 'package:budget_pro/presentation/screens/expenses.dart';
import 'package:budget_pro/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import './domain/routes/routes.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigatorCubit()),
        BlocProvider(create: (context) => ShowSelectOption()),
        BlocProvider(create: (context) => DateSelectorCubit()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Pro',
      home: App(),
      routes: {
        AppRoutes.home: (context) => const Home(),
        AppRoutes.expenses: (context) => const Expenses(),
        AppRoutes.charts: (context) => const Charts(),
        AppRoutes.exchanges: (context) => const Exchanges(),
      },
    );
  }
}
