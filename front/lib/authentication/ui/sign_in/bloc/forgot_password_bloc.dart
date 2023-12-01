import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc426_front/authentication/domain/usecases/forgot_password_usecase.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUsecase forgotPasswordUsecase;

  ForgotPasswordBloc(this.forgotPasswordUsecase) : super(ForgotPasswordInitial());

  void sendPasswordReset(String email) async {
    emit(ForgotPasswordLoading());
    try {
      final result = await forgotPasswordUsecase.call(email);
      if (result) {
        emit(ForgotPasswordSuccess());
      } else {
        emit(ForgotPasswordFailure());
      }
    } catch (_) {
      emit(ForgotPasswordFailure());
    }
  }
}