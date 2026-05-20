import 'package:budget_pro/data/models/income_item.dart';
import 'package:budget_pro/domain/income_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AddNewIncomeEvent {}

class AddNewIncomeItem extends AddNewIncomeEvent {
  String categoryName;
  String amount;
  String note;

  AddNewIncomeItem({
    required this.categoryName,
    required this.amount,
    required this.note,
  });
}

class LoadIncome extends AddNewIncomeEvent {}

class AddNewIncomeBloc extends Bloc<AddNewIncomeEvent, List<IncomeItem>> {
  IncomeRepository incomeRepository;
  AddNewIncomeBloc(this.incomeRepository) : super([]) {
    on<AddNewIncomeItem>((event, emit) async {
      final categoryName = event.categoryName;
      final amount = event.amount;
      final note = event.note;

      try {
        await incomeRepository.addData(categoryName, amount, note);
      } catch (e) {
        debugPrint(e.toString());
      }
    });

    on<LoadIncome>((event, emit) async {
      try {
        await emit.forEach(
          incomeRepository.getData(),
          onData: (incomeList) {
            return incomeList;
          },
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
