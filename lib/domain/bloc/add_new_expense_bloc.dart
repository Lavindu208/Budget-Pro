import 'package:budget_pro/data/models/expense_item.dart';
import 'package:budget_pro/domain/upload_expense_data.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewExpenseItem {
  String categoryName;
  String amount;
  IconData icon;
  AddNewExpenseItem(this.categoryName, this.amount, this.icon);
}

class AddNewExpenseBloc extends Bloc<AddNewExpenseItem, List<ExpenseItem>> {
  AddNewExpenseBloc() : super([]) {
    on<AddNewExpenseItem>((event, emit) {
      final categoryName = event.categoryName;
      final amount = event.amount;
      final icon = event.icon;

      final newItem = ExpenseItem(
        icon: icon,
        categoryName: categoryName,
        amount: amount,
      );
      final currentItems = state;
      if (currentItems.length < 4) {
        HomeScreenExpenses(homeScreenExpenseItems: [...currentItems, newItem]);
      }

      final updatedList = [...currentItems, newItem];
      UploadExpenseData(categoryName, amount).addData();

      emit(updatedList);
    });
  }
}
