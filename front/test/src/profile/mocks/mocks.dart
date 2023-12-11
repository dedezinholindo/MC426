import 'package:mc426_front/profile/domain/domain.dart';

const profileMock = ProfileEntity(
  name: "name_test",
  username: "username_test",
  email: "email_test@gmail.com",
  age: 20,
  phone: "phone_test",
  address: "address_test",
  photo: "photo_test",
  safetyNumber: "190",
);

const profileMapMock = {
  "name": "name_test",
  "username": "username_test",
  "email": "email_test@gmail.com",
  "age": 20,
  "phone": "phone_test",
  "password": "password_test",
  "address": "address_test",
  "photo": "photo_test",
  "safetyNumber": "190",
};

const userHeaderJson = {
  "photo": "photo",
  "name": "name",
};

const userHeaderNoPhotoJson = {
  "name": "name",
};

const userPostInfoJson = {
  "id": 1,
  "description": "description",
  "time": "2 horas",
  "local": "Rua Roxo Moreira, 45",
  "upVotes": 2,
  "downVotes": 2,
};

const userPostJson = {
  "header": userHeaderJson,
  "posts": [
    userPostInfoJson,
    {
      "id": 3,
      "description": "description",
      "time": "2 horas",
      "local": "Rua Roxo Moreira, 45",
      "upVotes": 2,
      "downVotes": 2,
    }
  ]
};

const userPostEmpty = {
  "header": {
    "photo": "photo",
    "name": "name",
  },
  "posts": []
};

const userPostNull = {
  "header": {
    "photo": "photo",
    "name": "name",
  },
};
