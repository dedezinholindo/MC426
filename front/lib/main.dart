import 'package:flutter/material.dart';
import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/create_complaint/complaint_page.dart';
import 'package:mc426_front/injection/injection.dart';
import 'package:mc426_front/profile/profile.dart';

void main() {
  setupProviders();
  runApp(const MyApp());
  initializeStorage();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Color(0x0A0A0AD9)),
      borderRadius: BorderRadius.circular(8),
    );

    return MaterialApp(
      title: 'Press2Safe',
      routes: {
        ComplaintPage.routeName: (context) => const ComplaintPage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        SignInPage.routeName: (context) => const SignInPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: const Color(0xFF4CE5B1),
          background: Colors.black,
        ),
        useMaterial3: true,
        fontFamily: "Mulish",
        primaryColor: const Color(0xFF4CE5B1),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: border,
          disabledBorder: border,
          focusedBorder: border,
          focusedErrorBorder: border,
          errorBorder: border,
          filled: true,
          errorStyle: const TextStyle(
            color: Color(0xFFFF0000),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          fillColor: const Color(0xFF141414),
          labelStyle: const TextStyle(
            color: Color(0xFF5F5F5F),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) return const Color(0xFFCDCDCD);
                return const Color(0xFF4CE5B1); // Use the component's default.
              },
            ),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
      ),
      home: const SignInPage(),
    );
  }
}
