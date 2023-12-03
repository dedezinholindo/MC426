import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/authentication/authentication.dart';
part 'sign_in_state.dart';

class SignInBloc extends Cubit<SignInState> {
  SignInBloc() : super(SignInLoadedState());

  final signInUsecase = GetIt.instance.get<SignInUsecase>();
  final ForgotPasswordUsecase forgotPasswordUsecase =
      GetIt.instance.get<ForgotPasswordUsecase>();

  void signIn({
    required String username,
    required String password,
  }) async {
    emit(SignInLoadedState(isLoading: true));
    final result = await signInUsecase.call(SignInEntity(
      username: username,
      password: password,
    ));
    emit(SignInLoadedState(result: result));
  }

  void forgotPassword(String email) async {
    try {
      final result = await forgotPasswordUsecase.call(email);
      emit(SignInForgotPasswordState(result));

    } catch (e) {
      emit(SignInLoadedState(isLoading: false));
    }
  }

  void clickForgotPassword() {
    emit(SignInForgotPasswordState(null));
  }

  void backToSignIn() {
    emit(SignInLoadedState());
  }
}