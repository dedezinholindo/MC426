import 'package:flutter/material.dart';

class UserPostsErrorView extends StatelessWidget {
  const UserPostsErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: Text(
          "Não foi possível completar a solicitação. \n\nPor favor tente novamente mais tarde",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
