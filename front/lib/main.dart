import 'package:flutter/material.dart';
import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/injection/injection.dart';
<<<<<<< HEAD
import 'package:mc426_front/create_complaint/complaint_page.dart';
import 'create_complaint/complaint.dart';
=======
>>>>>>> develop

void main() {
  setupProviders();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: 'Aplicativo de Denúncias',
=======
      title: 'Flutter Demo',
      routes: {
        AuthenticationPage.routeName: (context) => const AuthenticationPage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        SignInPage.routeName: (context) => const SignInPage(),
      },
>>>>>>> develop
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
<<<<<<< HEAD
      home: const ComplaintPage(),
=======
      home: const AuthenticationPage(),
>>>>>>> develop
    );
  }
}