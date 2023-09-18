import 'package:flutter/cupertino.dart';
import 'package:mc426_front/hello_world/hello_world.dart';

class HelloWorldSuccessView extends StatelessWidget {
  final HelloWorld helloWorld;
  const HelloWorldSuccessView({super.key, required this.helloWorld});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text(helloWorld.text)),
      ],
    );
  }
}
