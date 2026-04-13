import 'package:flutter_bloc/flutter_bloc.dart';

class LoginProgressIndicatorCubit extends Cubit<bool> {
  LoginProgressIndicatorCubit() : super(false);

  void showLoader() => emit(true);
  void hideLoader() => emit(false);
}
