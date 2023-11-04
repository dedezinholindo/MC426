import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/authentication/authentication.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Cubit<SignUpState> {
  SignUpBloc() : super(SignUpLoadedState());

  final signupUsecase = GetIt.instance.get<SignUpUsecase>();

  void signUp({
    required String username,
    required String password,
    required String age,
    required String name,
    required String email,
  }) async {
    emit(SignUpLoadedState(isLoading: true));
    final result = await signupUsecase.call(SignUpEntity(
      username: username,
      password: password,
      email: email,
      age: age,
      name: name,
    ));
    emit(SignUpLoadedState(result: result));
  }
}
