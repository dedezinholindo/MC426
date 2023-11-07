import 'package:mc426_front/authentication/authentication.dart';

const signInMock = SignInEntity(
  username: "username_test",
  password: "password_test",
);

const signUpMock = SignUpEntity(
  name: "name_test",
  username: "username_test",
  email: "email_test@gmail.com",
  age: "20",
  phone: "phone_test",
  password: "password_test",
  address: "address_test",
  photo: "photo_test",
  safetyNumber: "190",
);

const resultSignInSuccess = {"message": "Autenticação bem-sucedida"};

const resultSignUpSuccess = {"message": "Usuário cadastrado com sucesso"};

const resultError = {"message": "Senha inválida"};
