import 'package:flutter/material.dart';
import 'package:mc426_front/injection/injection.dart';
import 'package:mc426_front/Create_Complaint/complaint_page.dart';
import 'Create_Complaint/complaint.dart';

void main() {
  setupProviders();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicativo de Denúncias',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ComplaintPage(),
    );
  }
}