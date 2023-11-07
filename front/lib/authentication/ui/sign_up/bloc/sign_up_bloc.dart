import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/authentication/authentication.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Cubit<SignUpState> {
  SignUpBloc() : super(SignUpLoadedState());

  final signupUsecase = GetIt.instance.get<SignUpUsecase>();

  void signUp({
    required String name,
    required String username,
    required String email,
    required String age,
    required String phone,
    required String password,
    required String verifyPassword,
    String? address,
    String? photo,
    String? safetyNumber,
  }) async {
    emit(SignUpLoadedState(isLoading: true));

    if (password != verifyPassword) {
      return emit(
        SignUpLoadedState(
          result: const AuthenticationResult(
            isSuccess: false,
            message: "A senhas não batem, tente novamente",
          ),
        ),
      );
    }

    final result = await signupUsecase.call(SignUpEntity(
      name: name,
      username: username,
      email: email,
      age: age,
      phone: phone,
      password: password,
      address: address,
      photo: photo,
      safetyNumber: safetyNumber,
    ));
    emit(SignUpLoadedState(result: result));
  }
}
