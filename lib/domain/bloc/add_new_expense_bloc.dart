import 'package:budget_pro/data/models/expense_item.dart';
import 'package:budget_pro/domain/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

abstract class AddNewExpenseEvent {}

class AddNewExpenseItem extends AddNewExpenseEvent {
  String categoryName;
  String amount;
  String note;
  BuildContext context;
  AddNewExpenseItem(this.categoryName, this.amount, this.note, this.context);
}

class LoadExpenses extends AddNewExpenseEvent {}

class AddNewExpenseBloc extends Bloc<AddNewExpenseEvent, List<ExpenseItem>> {
  final ExpenseRepository expenseRepository;
  AddNewExpenseBloc(this.expenseRepository) : super([]) {
    on<AddNewExpenseItem>((event, emit) async {
      final categoryName = event.categoryName;
      final amount = event.amount;
      final note = event.note;
      final context = event.context;

      try {
        await expenseRepository.addData(categoryName, amount, note);
        if (context.mounted) {
          popScreen(context);
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    on<LoadExpenses>((event, emit) async {
      try {
        await emit.forEach(
          expenseRepository.getData(),
          onData: (expenseList) {
            return expenseList;
          },
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }

  void popScreen(BuildContext context) {
    Navigator.pop(context);
  }
}
