import 'package:flutter_bloc/flutter_bloc.dart';

class CreateInitListCubit extends Cubit<List<dynamic>> {
  CreateInitListCubit({required List<dynamic> initState}) : super(initState);
  int get len => state.length;
  List<int> initList = [];

  List<dynamic> createInitList() {
    for (int i = 0; i < len; i++) {
      initList.add(-1);
    }

    emit(initList);
    return initList;
  }
}
