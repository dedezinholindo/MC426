import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class SignUpLoadedView extends StatefulWidget {
  final void Function({
    String? name,
    String? username,
    String? email,
    String? age,
    String? phone,
    String? password,
    String? address,
    String? photo,
    String? safetyNumber,
    bool? passwordMatchParam,
  }) onChange;

  const SignUpLoadedView({super.key, required this.onChange});

  @override
  State<SignUpLoadedView> createState() => _SignUpLoadedViewState();
}

class _SignUpLoadedViewState extends State<SignUpLoadedView> {
  String? photo;
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController verifyPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController safetyNumberController = TextEditingController();
  ValueNotifier<bool> passwordMatch = ValueNotifier<bool>(true);

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      setState(() => photo = image.path);
      widget.onChange(photo: photo);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    ageController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    verifyPasswordController.dispose();
    addressController.dispose();
    safetyNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
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
              "NOME*",
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
              onChanged: (value) => widget.onChange(name: value),
            ),
            const SizedBox(height: 24),
            //username
            const Text(
              "USERNAME*",
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
              onChanged: (value) => widget.onChange(username: value),
            ),
            const SizedBox(height: 24),
            //email
            const Text(
              "EMAIL*",
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
              controller: emailController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'Digite seu email',
              ),
              onChanged: (value) => widget.onChange(email: value),
            ),
            const SizedBox(height: 24),
            //idade
            const Text(
              "IDADE*",
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
              onChanged: (value) => widget.onChange(age: value),
            ),
            const SizedBox(height: 24),
            //telefone
            const Text(
              "CELULAR*",
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
              onChanged: (value) => widget.onChange(phone: value),
            ),
            const SizedBox(height: 24),
            //senha
            const Text(
              "SENHA*",
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
              onChanged: (value) => widget.onChange(password: value),
            ),
            //senha verificacao
            const SizedBox(height: 12),
            ValueListenableBuilder<bool>(
              valueListenable: passwordMatch,
              builder: (context, value, child) {
                return TextFormField(
                  controller: verifyPasswordController,
                  obscureText: true,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Digite a senha novamente',
                    errorText: !value ? "As senhas não correspondem" : null,
                  ),
                  onChanged: (value) {
                    if (value != phoneController.text && value != "") {
                      passwordMatch.value = false;
                    } else {
                      passwordMatch.value = true;
                    }
                    widget.onChange(passwordMatchParam: passwordMatch.value);
                  },
                );
              },
            ),
            const SizedBox(height: 24),
            //endereço
            const Text(
              "ENDEREÇO*",
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
              onChanged: (value) => widget.onChange(address: value),
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
              onChanged: (value) => widget.onChange(safetyNumber: value),
            ),
            const SizedBox(height: 24),
            //photoController
            ElevatedButton(
              onPressed: pickImage,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "FOTO DE PERFIL",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3,
                    ),
                  ),
                  SizedBox(width: 12),
                  Icon(
                    Icons.photo,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
