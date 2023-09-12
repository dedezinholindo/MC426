import 'package:flutter/material.dart';

class HelloWorldLoading extends StatelessWidget {
  const HelloWorldLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
  }
}
