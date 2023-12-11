import 'package:flutter/material.dart';

class ComplaintMapErrorView extends StatelessWidget {
  const ComplaintMapErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Não foi possível completar a solicitação",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 24),
          Text(
            "Não foi possível carregar as denúncias feitas próximas a você. Por favor tente novamente mais tarde",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
