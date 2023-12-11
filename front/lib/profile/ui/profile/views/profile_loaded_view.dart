import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mc426_front/profile/domain/domain.dart';

class ProfileLoadedView extends StatefulWidget {
  final ProfileEntity profile;
  final void Function({
    String? name,
    String? phone,
    String? address,
    String? photo,
    String? safetyNumber,
  }) onChange;
  final bool isEditing;
  const ProfileLoadedView({required this.profile, required this.onChange, this.isEditing = false, super.key});

  @override
  State<ProfileLoadedView> createState() => _ProfileLoadedViewState();
}

class _ProfileLoadedViewState extends State<ProfileLoadedView> {
  String? photo;

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
            //foto
            Center(
              child: InkWell(
                onTap: widget.isEditing ? pickImage : null,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[800],
                  backgroundImage: widget.profile.photo != null
                      ? Image.file(
                          File(widget.profile.photo!),
                          fit: BoxFit.cover,
                        ).image
                      : null,
                  child: widget.profile.photo == null
                      ? SvgPicture.asset(
                          "assets/images/sign_icon.svg",
                          width: 24,
                        )
                      : null,
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              initialValue: widget.profile.name,
              enabled: widget.isEditing,
              onChanged: (value) => widget.onChange(name: value),
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              initialValue: widget.profile.username,
              enabled: false,
            ),
            const SizedBox(height: 24),
            //email
            const Text(
              "EMAIL",
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              initialValue: widget.profile.email,
              enabled: false,
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              initialValue: widget.profile.age.toString(),
              enabled: false,
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              initialValue: widget.profile.phone,
              enabled: widget.isEditing,
              onChanged: (value) => widget.onChange(phone: value),
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              initialValue: widget.profile.address,
              enabled: widget.isEditing,
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              initialValue: widget.profile.safetyNumber,
              enabled: widget.isEditing,
              onChanged: (value) => widget.onChange(safetyNumber: value),
            ),
            const SizedBox(height: 24),
            const Text(
              "Clique em editar para alterar as informações",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Color(0xFFCDCDCD),
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
