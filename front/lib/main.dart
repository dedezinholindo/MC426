import 'package:flutter/material.dart';
import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/injection/injection.dart';

void main() {
  setupProviders();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        AuthenticationPage.routeName: (context) => const AuthenticationPage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        SignInPage.routeName: (context) => const SignInPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const AuthenticationPage(),
    );
  }
}
