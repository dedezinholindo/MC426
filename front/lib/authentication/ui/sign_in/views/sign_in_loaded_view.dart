import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mc426_front/authentication/authentication.dart';

class SignInLoadedView extends StatefulWidget {
  final bool isLoading;
  final void Function(String username, String password) signIn;

  const SignInLoadedView({required this.isLoading, required this.signIn, super.key});

  @override
  State<SignInLoadedView> createState() => _SignInLoadedViewState();
}

class _SignInLoadedViewState extends State<SignInLoadedView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 72),
            SvgPicture.asset(
              "assets/images/sign_icon.svg",
              width: 24,
            ),
            const SizedBox(height: 48),
            const Text(
              "Bem-vindo ao Press2Safe",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "USERNAME",
                  style: TextStyle(
                    color: Color(0xFFCDCDCD),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: emailController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Informe seu email ou username',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "SENHA",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color(0xFFCDCDCD),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Informe sua senha',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Esqueci a senha",
                  style: TextStyle(
                    color: Color(0xFF1DAEFF),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => widget.signIn(emailController.text, passwordController.text),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: () => Navigator.of(context).pushNamed(SignUpPage.routeName),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Não possui conta?",
                    style: TextStyle(
                      color: Color(0xFF81818A),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 2),
                  Text(
                    "Cadastre-se",
                    style: TextStyle(
                      color: Color(0xFF1DAEFF),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
