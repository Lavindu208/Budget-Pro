import 'package:flutter_bloc/flutter_bloc.dart';

class ShowActionButtonsCubit extends Cubit<bool> {
  ShowActionButtonsCubit() : super(false);

  void showButtons() => emit(true);
  void hideButtons(List<DateTime> itemList) {
    int len = itemList.length;
    if (len == 0) {
      emit(false);
    }
  }
}
