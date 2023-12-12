import 'package:flutter/material.dart';

class EmergencyButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const EmergencyButton({Key? key, required this.title, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}