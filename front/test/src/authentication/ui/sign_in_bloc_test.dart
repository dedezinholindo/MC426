import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/authentication/ui/sign_in/bloc/sign_in_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

class SignInUsecaseMock extends Mock implements SignInUsecase {}
class ForgotPasswordUsecaseMock extends Mock implements ForgotPasswordUsecase {}

void main() {
  late final SignInUsecase signInUsecase;
  late ForgotPasswordUsecase forgotPasswordUsecase;

  setUpAll(() {
    final injection = GetIt.instance;
    signInUsecase = SignInUsecaseMock();
    forgotPasswordUsecase = ForgotPasswordUsecaseMock();

    injection.registerFactory<SignInUsecase>(() => signInUsecase);
    injection
        .registerFactory<ForgotPasswordUsecase>(() => forgotPasswordUsecase);
    registerFallbackValue(signInMock);
    registerFallbackValue(const SignInEntity(username: "", password: ""));
  });

  group("signIn", () {
    blocTest<SignInBloc, SignInState>(
      'should return AuthenticationResult success when the request is completed',
      build: () {
        when(() => signInUsecase.call(any()))
            .thenAnswer((_) async => AuthenticationResult(
                  isSuccess: true,
                  message: resultSignInSuccess["message"] ?? "",
                ));
        return SignInBloc();
      },
      act: (bloc) => bloc.signIn(username: "", password: ""),
      expect: () => [
        isA<SignInLoadedState>().having((s) => s.isLoading, "is loading", true),
        isA<SignInLoadedState>()
            .having((s) => s.isLoading, "is loading", false),
      ],
    );

    blocTest<SignInBloc, SignInState>(
      'should return AuthenticationResult fails when the request is failed',
      build: () {
        when(() => signInUsecase.call(any()))
            .thenAnswer((_) async => AuthenticationResult(
                  isSuccess: false,
                  message: resultError["message"] ?? "",
                ));
        return SignInBloc();
      },
      act: (bloc) => bloc.signIn(username: "", password: ""),
      expect: () => [
        isA<SignInLoadedState>().having((s) => s.isLoading, "is loading", true),
        isA<SignInLoadedState>()
            .having((s) => s.isLoading, "is loading", false),
      ],
    );
  });
  group("Forgot Password", () {
    blocTest<SignInBloc, SignInState>(
      'should emit SignInForgotPasswordState when forgotPassword is called successfully',
      build: () {
        when(() => forgotPasswordUsecase.call(any()))
            .thenAnswer((_) async => true);
        return SignInBloc();
      },
      act: (bloc) => bloc.forgotPassword("test@example.com"),
      expect: () => [isA<SignInForgotPasswordState>()],
    );

    blocTest<SignInBloc, SignInState>(
      'should emit SignInLoadedState when backToSignIn is called',
      build: () => SignInBloc(),
      act: (bloc) => bloc.backToSignIn(),
      expect: () => [isA<SignInLoadedState>()],
    );

    blocTest<SignInBloc, SignInState>(
      'should emit SignInForgotPasswordState when clickForgotPassword is called',
      build: () => SignInBloc(),
      act: (bloc) => bloc.clickForgotPassword(),
      expect: () => [isA<SignInForgotPasswordState>()],
    );
  });
}
