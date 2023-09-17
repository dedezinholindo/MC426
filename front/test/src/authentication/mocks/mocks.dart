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

const resultSignInSuccess = {"mensagem": "Autenticação bem-sucedida"};

const resultSignUpSuccess = {"mensagem": "Usuário cadastrado com sucesso"};

const resultError = {"mensagem": "Senha inválida"};
