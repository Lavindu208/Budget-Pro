import 'dart:async';
import 'package:budget_pro/data/models/income_item.dart';
import 'package:budget_pro/domain/income_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectIncomeItemsCubit extends Cubit<List<int>> {
  final IncomeRepository _incomeRepository = IncomeRepository();
  late StreamSubscription<List<IncomeItem>> _subscription;
  SelectIncomeItemsCubit({required List<IncomeItem> incomeItems})
    : super(List.filled(incomeItems.length, -1));

  List<int> initList = [];
  List<DateTime> selectedItems = [];

  void initializedWithLoadData() {
    try {
      _subscription = _incomeRepository.getData().listen((data) {
        initList = List.filled(data.length, -1);
        emit(initList);
        selectedItems.clear();
      });
    } catch (e) {
      debugPrint("error creating initial income list : $e");
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
