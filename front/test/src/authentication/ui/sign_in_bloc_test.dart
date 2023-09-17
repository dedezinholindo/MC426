import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/authentication/ui/sign_in/bloc/sign_in_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

class SignInUsecaseMock extends Mock implements SignInUsecase {}

void main() {
  late final SignInUsecase signInUsecase;

  setUpAll(() {
    final injection = GetIt.instance;
    signInUsecase = SignInUsecaseMock();

    injection.registerFactory<SignInUsecase>(() => signInUsecase);
    registerFallbackValue(signInMock);
  });

  group("signIn", () {
    blocTest<SignInBloc, SignInState>(
      'should return AuthenticationResult success when the request is completed',
      build: () {
        when(() => signInUsecase.call(any())).thenAnswer((_) async => AuthenticationResult(
              isSuccess: true,
              message: resultSignInSuccess["mensagem"] ?? "",
            ));
        return SignInBloc();
      },
      act: (bloc) => bloc.signIn(username: "", password: ""),
      expect: () => [
        isA<SignInLoadedState>().having((s) => s.isLoading, "is loading", true),
        isA<SignInLoadedState>().having((s) => s.isLoading, "is loading", false),
      ],
    );

    blocTest<SignInBloc, SignInState>(
      'should return AuthenticationResult fails when the request is failed',
      build: () {
        when(() => signInUsecase.call(any())).thenAnswer((_) async => AuthenticationResult(
              isSuccess: false,
              message: resultError["mensagem"] ?? "",
            ));
        return SignInBloc();
      },
      act: (bloc) => bloc.signIn(username: "", password: ""),
      expect: () => [
        isA<SignInLoadedState>().having((s) => s.isLoading, "is loading", true),
        isA<SignInLoadedState>().having((s) => s.isLoading, "is loading", false),
      ],
    );
  });
}
