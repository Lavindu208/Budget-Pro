import 'package:budget_pro/app.dart';
import 'package:budget_pro/domain/authentication/auth_gate.dart';
import 'package:budget_pro/domain/bloc/add_new_expense_bloc.dart';
import 'package:budget_pro/domain/bloc/add_new_income_bloc.dart';
import 'package:budget_pro/domain/bloc/bottomNavigator/navigator_event.dart';
import 'package:budget_pro/domain/bloc/calculate_total_expense_cubit.dart';
import 'package:budget_pro/domain/bloc/date_selector.dart';
import 'package:budget_pro/domain/bloc/display_category_cubit.dart';
import 'package:budget_pro/domain/bloc/login_progress_indicator_cubit.dart';
import 'package:budget_pro/domain/bloc/select_expense_items_cubit.dart';
import 'package:budget_pro/domain/bloc/select_income_items_cubit.dart';
import 'package:budget_pro/domain/bloc/show_action_buttons_cubit.dart';
import 'package:budget_pro/domain/bloc/signup_progress_indicator_cubit.dart';
import 'package:budget_pro/domain/expense_repository.dart';
import 'package:budget_pro/domain/income_repository.dart';
import 'package:budget_pro/firebase_options.dart';
import 'package:budget_pro/presentation/screens/addExpense.dart';
import 'package:budget_pro/presentation/screens/add_income.dart';
import 'package:budget_pro/presentation/screens/log_in.dart';
import 'package:budget_pro/presentation/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './domain/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ExpenseRepository>(
          create: (context) => ExpenseRepository(),
        ),
        RepositoryProvider<IncomeRepository>(
          create: (context) => IncomeRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NavigatorCubit()),
          BlocProvider(create: (context) => DateSelectorCubit()),
          BlocProvider(create: (context) => DisplayCategoryCubit()),
          BlocProvider(create: (context) => LoginProgressIndicatorCubit()),
          BlocProvider(create: (context) => SignupProgressIndicatorCubit()),
          BlocProvider(create: (context) => ShowActionButtonsCubit()),
          BlocProvider(
            create: (context) =>
                AddNewExpenseBloc(context.read<ExpenseRepository>())
                  ..add(LoadExpenses()),
          ),
          BlocProvider(
            create: (context) => CalculateTotalExpenseCubit(
              expensesList: context.read<AddNewExpenseBloc>().state,
            )..calculateTotal(),
            lazy: false,
          ),
          BlocProvider(
            create: (context) =>
                AddNewIncomeBloc(context.read<IncomeRepository>())
                  ..add(LoadIncome()),
          ),
          BlocProvider(
            create: (context) => SelectIncomeItemsCubit(
              incomeItems: context.read<AddNewIncomeBloc>().state,
            )..initializedWithLoadData(),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => SelectExpenseItemCubit(
              expenseItems: context.read<AddNewExpenseBloc>().state,
            )..initializedWithLoadData(),
            lazy: false,
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Budget Pro',
          home: AuthGate(),
          routes: {
            AppRoutes.addExpense: (context) => const AddExpense(),
            AppRoutes.addIncome: (context) => const AddIncome(),
            AppRoutes.signUp: (context) => const SignUp(),
            AppRoutes.logIn: (context) => const LogIn(),
            AppRoutes.app: (context) => const App(),
          },
        ),
      ),
    );
  }
}
