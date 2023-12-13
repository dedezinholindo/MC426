import 'package:flutter/material.dart';

class ProfileErrorView extends StatelessWidget {
  final bool isEditing;
  const ProfileErrorView({this.isEditing = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Não foi possível completar a solicitação",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          isEditing
              ? const Text(
                  "Não foi possível realizar a edicão dos dados. Por favor tente novamente mais tarde",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                )
              : const Text(
                  "Não foi possível buscar os dados de perfil. Por favor tente novamente mais tarde",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
        ],
      ),
    );
  }
}
