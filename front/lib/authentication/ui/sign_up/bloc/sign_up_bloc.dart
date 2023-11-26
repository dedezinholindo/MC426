import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/authentication/authentication.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Cubit<SignUpState> {
  SignUpBloc() : super(SignUpLoadedState(const SignUpStateParams()));

  final signupUsecase = GetIt.instance.get<SignUpUsecase>();

  ValueNotifier<bool> isAvailable = ValueNotifier<bool>(false);

  var _signUpEntity = SignUpEntity.empty();
  bool passwordMatch = false;

  @override
  Future<void> close() async {
    isAvailable.dispose();
    super.close();
  }

  void signUp() async {
    emit(SignUpLoadedState(state.params.copyWith(isLoading: true)));

    if (!passwordMatch) {
      return emit(
        SignUpLoadedState(
          state.params.copyWith(isLoading: false),
          result: const AuthenticationResult(
            isSuccess: false,
            message: "A senhas não batem, tente novamente",
          ),
        ),
      );
    }

    final result = await signupUsecase.call(_signUpEntity);

    emit(SignUpLoadedState(state.params.copyWith(isLoading: false), result: result));
  }

  void changeForms({
    String? name,
    String? username,
    String? email,
    String? age,
    String? phone,
    String? password,
    String? address,
    String? photo,
    String? safetyNumber,
    bool? passwordMatchParam,
  }) async {
    _signUpEntity = _signUpEntity.copyWith(
      name: name,
      username: username,
      email: email,
      age: age,
      phone: phone,
      password: password,
      address: address,
      photo: photo,
      safetyNumber: safetyNumber,
    );

    passwordMatch = passwordMatchParam ?? passwordMatch;
    isAvailable.value = _signUpEntity.isAvailable && passwordMatch;
  }
}
