import 'package:flutter/material.dart';
import 'package:mc426_front/home/home.dart';

class EmergencyView extends StatelessWidget {
  final VoidCallback contactEmergency;
  final VoidCallback police;
  final VoidCallback panicButton;

  const EmergencyView({
    Key? key,
    required this.contactEmergency,
    required this.police,
    required this.panicButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          EmergencyButton(
            title: "Contato de Emergência",
            onPressed: contactEmergency,
          ),
          const SizedBox(height: 40),
          EmergencyButton(
            title: "Polícia",
            onPressed: police,
          ),
          const SizedBox(height: 40),
          EmergencyButton(
            title: "Botão do Pânico",
            onPressed: panicButton,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
