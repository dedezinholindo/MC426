import 'package:flutter/material.dart';

class HomeErrorView extends StatelessWidget {
  final VoidCallback reload;
  const HomeErrorView({required this.reload, super.key});

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
          const Text(
            "Não foi carregar a home. Por favor tente novamente mais tarde",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: reload,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tentar novamente'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
