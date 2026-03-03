import 'package:budget_pro/domain/bloc/bottomNavigator/navigator_event.dart';
import 'package:budget_pro/domain/bloc/date_selector.dart';
import 'package:budget_pro/domain/bloc/display_category_cubit.dart';
import 'package:budget_pro/presentation/screens/addExpense.dart';
import 'package:budget_pro/presentation/screens/add_income.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import './domain/routes/routes.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigatorCubit()),
        BlocProvider(create: (context) => DateSelectorCubit()),
        BlocProvider(create: (context) => DisplayCategoryCubit()),
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
        AppRoutes.addExpense: (context) => const AddExpense(),
        AppRoutes.addIncome: (context) => const AddIncome(),
      },
    );
  }
}
