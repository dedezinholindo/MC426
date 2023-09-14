import 'package:flutter/material.dart';
import 'package:mc426_front/injection/injection.dart';

import 'hello_world/hello_world.dart';

void main() {
  setupProviders();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HelloWorldPage(),
    );
  }
}
