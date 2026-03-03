import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayCategoryCubit extends Cubit<String> {
  DisplayCategoryCubit() : super('none');

  void displayExpenseCategory(String categoryName) {
    emit(categoryName);
  }

  void displayIncomeCategory(String categoryName) {
    emit(categoryName);
  }
}
