import 'package:flutter/material.dart';

class SignUpLoadedView extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String username,
    String password,
    String age,
    String name,
    String email,
  ) signUp;

  const SignUpLoadedView({super.key, required this.isLoading, required this.signUp});

  @override
  State<SignUpLoadedView> createState() => _SignUpLoadedViewState();
}

class _SignUpLoadedViewState extends State<SignUpLoadedView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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
            decoration: const InputDecoration(
              labelText: 'Senha',
              hintText: 'Informe sua senha',
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: ageController,
            decoration: const InputDecoration(
              labelText: 'Idade',
              hintText: 'Informe sua idade',
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Nome',
              hintText: 'Informe seu nome',
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Informe seu email',
            ),
          ),
          ElevatedButton(
            onPressed: () => widget.signUp(
                usernameController.text, passwordController.text, ageController.text, nameController.text, emailController.text),
            child: widget.isLoading ? const CircularProgressIndicator() : const Text('Cadastrar'),
          ),
        ],
      ),
    );
  }
}
