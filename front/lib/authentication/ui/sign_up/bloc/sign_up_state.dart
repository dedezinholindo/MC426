part of 'sign_up_bloc.dart';

class SignUpStateParams {
  final bool isLoading;
  final SignUpEntity signUpEntity;

  const SignUpStateParams({
    required this.signUpEntity,
    this.isLoading = false,
  });

  SignUpStateParams copyWith({
    SignUpEntity? signUpEntity,
    bool? isLoading,
  }) {
    return SignUpStateParams(signUpEntity: signUpEntity ?? this.signUpEntity, isLoading: isLoading ?? this.isLoading);
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
