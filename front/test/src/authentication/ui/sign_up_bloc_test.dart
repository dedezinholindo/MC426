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
      act: (bloc) => bloc.signUp(
        name: "name_test",
        username: "username_test",
        email: "email_test@gmail.com",
        age: "20",
        phone: "phone_test",
        password: "password_test",
        verifyPassword: "password_test",
        address: "address_test",
        photo: "photo_test",
        safetyNumber: "190",
      ),
      expect: () => [
        isA<SignUpLoadedState>().having((s) => s.isLoading, "is loading", true),
        isA<SignUpLoadedState>().having((s) => s.result?.isSuccess, "success", true).having((s) => s.isLoading, "is loading", false),
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
      act: (bloc) => bloc.signUp(
        name: "name_test",
        username: "username_test",
        email: "email_test@gmail.com",
        age: "20",
        phone: "phone_test",
        password: "password_test",
        verifyPassword: "password_test",
        address: "address_test",
        photo: "photo_test",
        safetyNumber: "190",
      ),
      expect: () => [
        isA<SignUpLoadedState>().having((s) => s.isLoading, "is loading", true),
        isA<SignUpLoadedState>().having((s) => s.result?.isSuccess, "success", false).having((s) => s.isLoading, "is loading", false),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'should return AuthenticationResult fails when password does not match',
      build: () {
        return SignUpBloc();
      },
      act: (bloc) => bloc.signUp(
        name: "name_test",
        username: "username_test",
        email: "email_test@gmail.com",
        age: "20",
        phone: "phone_test",
        password: "password_test",
        verifyPassword: "password_test_123",
        address: "address_test",
        photo: "photo_test",
        safetyNumber: "190",
      ),
      expect: () => [
        isA<SignUpLoadedState>().having((s) => s.isLoading, "is loading", true),
        isA<SignUpLoadedState>().having((s) => s.result?.isSuccess, "success", false).having((s) => s.isLoading, "is loading", false),
      ],
    );
  });
}
