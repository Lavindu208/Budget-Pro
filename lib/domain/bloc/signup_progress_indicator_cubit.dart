import 'package:flutter_bloc/flutter_bloc.dart';

class SignupProgressIndicatorCubit extends Cubit<bool> {
  SignupProgressIndicatorCubit() : super(false);

  void showLoader() => emit(true);
  void hideLoader() => emit(false);
}
