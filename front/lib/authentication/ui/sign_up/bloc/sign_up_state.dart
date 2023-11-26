part of 'sign_up_bloc.dart';

class SignUpStateParams {
  final bool isLoading;

  const SignUpStateParams({this.isLoading = false});

  SignUpStateParams copyWith({
    bool? isLoading,
  }) {
    return SignUpStateParams(isLoading: isLoading ?? this.isLoading);
  }
}

sealed class SignUpState {
  final SignUpStateParams params;

  const SignUpState(this.params);
}

class SignUpLoadedState extends SignUpState {
  final AuthenticationResult? result;

  SignUpLoadedState(super.params, {this.result});
}
