import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DateSelectorCubit extends Cubit<String> {
  DateSelectorCubit() : super('Today');

  Future<void> selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final firstDateOfMonth = DateTime(now.year, now.month, 1);
    final lastDateOfMonth = DateTime(now.year, now.month, now.day);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDateOfMonth,
      lastDate: lastDateOfMonth,
    );

    if (pickedDate == null) {
      emit(dateFormatter(now));
    } else if (pickedDate.day == now.day) {
      emit('Today');
    } else {
      emit(dateFormatter(pickedDate));
    }
  }

  String dateFormatter(DateTime date) {
    String formattedDate = DateFormat.yMMMd().format(date);

    return formattedDate;
  }
}
