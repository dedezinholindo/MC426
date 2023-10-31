import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/authentication/ui/sign_up/bloc/sign_up_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

class SignUpUsecaseMock extends Mock implements SignUpUsecase {}

void main() {
  late final SignUpUsecase signUpUsecase;

  setUpAll(() {
    final injection = GetIt.instance;
    signUpUsecase = SignUpUsecaseMock();

    injection.registerFactory<SignUpUsecase>(() => signUpUsecase);
    registerFallbackValue(signUpMock);
  });

  group("signUp", () {
    blocTest<SignUpBloc, SignUpState>(
      'should return AuthenticationResult success when the request is completed',
      build: () {
        when(() => signUpUsecase.call(any())).thenAnswer((_) async => AuthenticationResult(
              isSuccess: true,
              message: resultSignUpSuccess["message"] ?? "",
            ));
        return SignUpBloc();
      },
      act: (bloc) => bloc.signUp(username: "", password: "", age: "", name: "", email: ""),
      expect: () => [
        isA<SignUpLoadedState>().having((s) => s.isLoading, "is loading", true),
        isA<SignUpLoadedState>().having((s) => s.isLoading, "is loading", false),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'should return AuthenticationResult fails when the request is failed',
      build: () {
        when(() => signUpUsecase.call(any())).thenAnswer((_) async => AuthenticationResult(
              isSuccess: false,
              message: resultError["message"] ?? "",
            ));
        return SignUpBloc();
      },
      act: (bloc) => bloc.signUp(username: "", password: "", age: "", name: "", email: ""),
      expect: () => [
        isA<SignUpLoadedState>().having((s) => s.isLoading, "is loading", true),
        isA<SignUpLoadedState>().having((s) => s.isLoading, "is loading", false),
      ],
    );
  });
}
