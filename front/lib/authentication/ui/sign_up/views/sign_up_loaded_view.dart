import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUpLoadedView extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String name,
    String username,
    String email,
    String age,
    String phone,
    String password,
    String verifyPassword,
    String? address,
    String? photo,
    String? safetyNumber,
  ) signUp;

  const SignUpLoadedView({super.key, required this.isLoading, required this.signUp});

  @override
  State<SignUpLoadedView> createState() => _SignUpLoadedViewState();
}

class _SignUpLoadedViewState extends State<SignUpLoadedView> {

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController verifyPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  TextEditingController safetyNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 48),
            Center(
              child: SvgPicture.asset(
                "assets/images/sign_icon.svg",
                width: 24,
              ),
            ),
            const SizedBox(height: 48),
            const Center(
              child: Text(
                "Cadastro",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 24),
            //nome
            const Text(
              "NOME",
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
              controller: nameController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'Digite seu nome',
              ),
            ),
            const SizedBox(height: 24),
            //username
            const Text(
              "USERNAME",
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
              controller: usernameController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'Digite seu username',
              ),
            ),
            const SizedBox(height: 24),
            //idade
            const Text(
              "IDADE",
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
              controller: ageController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'Digite sua idade',
              ),
            ),
            const SizedBox(height: 24),
            //telefone
            const Text(
              "CELULAR",
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
              controller: phoneController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'Digite seu número de celular',
              ),
            ),
            const SizedBox(height: 24),
            //senha
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
              controller: passwordController,
              obscureText: true,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'Digite sua senha',
              ),
            ),
            //senha verificacao
            const SizedBox(height: 12),
            TextFormField(
              controller: verifyPasswordController,
              obscureText: true,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'Digite a senha novamente',
              ),
            ),
            const SizedBox(height: 24),
            //endereço
            const Text(
              "ENDEREÇO",
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
              controller: addressController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'Digite seu endereço',
              ),
            ),
            const SizedBox(height: 24),
            //numero de emergência
            const Text(
              "NÚMERO DE EMERGÊNCIA",
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
              controller: safetyNumberController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'Digite um número de emergência',
              ),
            ),
            const SizedBox(height: 24),
            //photoController
            const Text(
              "FOTO DE PERFIL",
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
              controller: photoController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'Escolha uma foto',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => widget.signUp(
                nameController.text,
                usernameController.text,
                emailController.text,
                ageController.text,
                phoneController.text,
                passwordController.text,
                verifyPasswordController.text,
                addressController.text,
                photoController.text,
                safetyNumberController.text,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Cadastrar',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
