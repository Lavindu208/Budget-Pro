import 'package:budget_pro/data/models/income_item.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewIncomeItem {
  String categoryName;
  String amount;
  IconData icon;

  AddNewIncomeItem({
    required this.categoryName,
    required this.amount,
    required this.icon,
  });
}

class AddNewIncomeBloc extends Bloc<AddNewIncomeItem, List<IncomeItem>> {
  AddNewIncomeBloc() : super([]) {
    on<AddNewIncomeItem>((event, emit) {
      final categoryName = event.categoryName;
      final amount = event.amount;
      final icon = event.icon;

      final newItem = IncomeItem(
        icon: icon,
        categoryName: categoryName,
        amount: amount,
      );
      final currentItems = state;

      final updatedList = [...currentItems, newItem];
      emit(updatedList);
    });
  }
}
