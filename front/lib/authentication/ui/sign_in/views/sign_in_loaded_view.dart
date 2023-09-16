import 'package:flutter/material.dart';

class SignInLoadedView extends StatefulWidget {
  final bool isLoading;
  final void Function(String username, String password) signIn;

  const SignInLoadedView({required this.isLoading, required this.signIn, super.key});

  @override
  State<SignInLoadedView> createState() => _SignInLoadedViewState();
}

class _SignInLoadedViewState extends State<SignInLoadedView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              hintText: 'Informe seu username',
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Senha',
              hintText: 'Informe sua senha',
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => widget.signIn(usernameController.text, passwordController.text),
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
