import 'dart:async';
import 'package:budget_pro/data/models/expense_item.dart';
import 'package:budget_pro/domain/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectExpenseItemCubit extends Cubit<List<int>> {
  final ExpenseRepository _expenseRepository = ExpenseRepository();
  late StreamSubscription<List<ExpenseItem>> _subscription;
  SelectExpenseItemCubit({required List<ExpenseItem> expenseItems})
    : super(List.filled(expenseItems.length, -1));
  List<int> initList = [];
  List<DateTime> selectedItems = [];

  void initializedWithLoadData() {
    try {
      _subscription = _expenseRepository.getData().listen((data) {
        initList = List.filled(data.length, -1);
        emit(initList);
        selectedItems.clear();
      });
    } catch (e) {
      debugPrint("error creating initial expense list : $e");
    }
  }

  void selectMultiple(int index, DateTime timestamp) {
    final updatedItems = List<int>.from(initList);
    updatedItems[index] = index;
    selectedItems.add(timestamp);
    initList[index] = index;
    emit(updatedItems);
  }

  void selectFirstItem(int index, DateTime timestamp) {
    HapticFeedback.vibrate();
    if (selectedItems.isEmpty) {
      selectMultiple(index, timestamp);
    }
  }

  void deleteItem(DateTime timestamp) {
    for (DateTime item in selectedItems) {
      if (item.isAtSameMomentAs(timestamp)) {
        selectedItems.removeAt(selectedItems.indexOf(item));
        break;
      }
    }
  }

  void unSelect(int index, DateTime timestamp) {
    final updatedList = List<int>.from(initList);
    updatedList[index] = -1;
    initList[index] = -1;
    deleteItem(timestamp);
    emit(updatedList);
  }

  void selectMultipleItems(int index, DateTime timestamp) {
    if (selectedItems.contains(timestamp)) {
      unSelect(index, timestamp);
    } else {
      if (selectedItems.isNotEmpty) {
        selectMultiple(index, timestamp);
      }
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
