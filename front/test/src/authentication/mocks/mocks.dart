import 'package:mc426_front/authentication/authentication.dart';

const signInMock = SignInEntity(
  username: "username_test",
  password: "password_test",
);

const signUpMock = SignUpEntity(
  username: "username_test",
  password: "password_test",
  name: "name_test",
  age: "20",
  email: "email_test@gmail.com",
);

const resultSignInSuccess = {"message": "Autenticação bem-sucedida"};

const resultSignUpSuccess = {"message": "Usuário cadastrado com sucesso"};

const resultError = {"message": "Senha inválida"};
