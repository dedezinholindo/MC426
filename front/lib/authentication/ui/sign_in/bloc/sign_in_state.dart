part of 'sign_in_bloc.dart';

sealed class SignInState {}

class SignInLoadedState extends SignInState {
  final bool isLoading;
  final AuthenticationResult? result;

  SignInLoadedState({this.isLoading = false, this.result});
}

class SignInForgotPasswordState extends SignInState {
  final bool? result;

  SignInForgotPasswordState(this.result);
}