import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/authentication/authentication.dart';

part 'sign_in_state.dart';

class SignInBloc extends Cubit<SignInState> {
  SignInBloc() : super(SignInLoadedState());

  final signInUsecase = GetIt.instance.get<SignInUsecase>();

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
}
