import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectExpenseItem extends Cubit<List<dynamic>> {
  SelectExpenseItem({required List<dynamic> initState}) : super(initState);
  List<dynamic> get selectedItems => state;
  List<int> items = [];

  void addItemToList() {
    selectedItems.add(-1);
  }

  void createInitList(int prevLen) {
    int len = prevLen - items.length;
    selectedItems.clear();
    for (int i = 0; i < len; i++) {
      selectedItems.add(-1);
    }
  }

  void resetItems() {
    bool isInitialClick = true;
    for (var el in selectedItems) {
      if (el != -1) {
        isInitialClick = false;
      }
    }
    if (isInitialClick) {
      items.clear();
    }
  }

  void selectMultiple(int index) {
    final updatedItems = List<dynamic>.from(selectedItems);
    updatedItems[index] = index;
    emit(updatedItems);
    selectedItems[index] = index;
    items.add(index);
  }

  void selectFirstItem(int index) {
    resetItems();
    selectMultiple(index);
    HapticFeedback.vibrate();
  }

  void selectMultipleItems(int index) {
    if (selectedItems.contains(index)) {
      unSelect(index);
    } else {
      if (items.isNotEmpty) {
        selectMultiple(index);
      }
    }
  }

  void unSelect(int index) {
    final updatedItems = List<dynamic>.from(selectedItems);
    updatedItems[index] = -1;
    selectedItems[index] = -1;
    items.remove(index);
    emit(updatedItems);
  }
}
