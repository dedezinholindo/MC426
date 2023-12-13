import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/authentication/authentication.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Cubit<SignUpState> {
  SignUpBloc() : super(SignUpLoadedState(SignUpStateParams(signUpEntity: SignUpEntity.empty())));

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
    emit(SignUpLoadedState(state.params.copyWith(signUpEntity: _signUpEntity, isLoading: true)));

    if (!passwordMatch) {
      isAvailable.value = false;
      passwordMatch = false;
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

    if (!result.isSuccess) {
      passwordMatch = false;
      isAvailable.value = false;
    }

    emit(SignUpLoadedState(state.params.copyWith(signUpEntity: _signUpEntity, isLoading: false), result: result));
  }

  void changeForms({
    SignUpEntity? signUpEntity,
    bool? passwordMatchParam,
  }) async {
    _signUpEntity = signUpEntity ?? _signUpEntity;

    passwordMatch = passwordMatchParam ?? passwordMatch;
    isAvailable.value = _signUpEntity.isAvailable && passwordMatch;
  }
}
