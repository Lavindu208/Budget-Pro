import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayCategoryCubit extends Cubit<String> {
  DisplayCategoryCubit() : super('none');

  void displayCategory(String categoryName) {
    emit(categoryName);
  }
}
