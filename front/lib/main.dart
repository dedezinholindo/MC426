import 'package:flutter/material.dart';
import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/create_complaint/complaint_page.dart';
import 'package:mc426_front/injection/injection.dart';
import 'package:mc426_front/profile/profile.dart';

import 'create_complaint/complaint.dart';

void main() {
  setupProviders();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicativo de Denúncias',
      routes: {
        AuthenticationPage.routeName: (context) => const AuthenticationPage(),
        ComplaintPage.routeName: (context) => const ComplaintPage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        SignInPage.routeName: (context) => const SignInPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(background: Colors.black, seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const ComplaintPage(),
    );
  }
}
