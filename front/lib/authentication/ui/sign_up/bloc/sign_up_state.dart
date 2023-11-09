part of 'sign_up_bloc.dart';

sealed class SignUpState {}

class SignUpLoadedState extends SignUpState {
  final bool isLoading;
  final AuthenticationResult? result;

  SignUpLoadedState({this.isLoading = false, this.result});
}
