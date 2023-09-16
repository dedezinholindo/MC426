import 'package:flutter/material.dart';
import 'package:mc426_front/authentication/authentication.dart';

class AuthenticationPage extends StatefulWidget {
  static const String routeName = '/authentication';

  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed(SignUpPage.routeName),
                child: Text("Cadastre-se"),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed(SignInPage.routeName),
                child: Text("Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
