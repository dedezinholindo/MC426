import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/complaint/complaint_page.dart';
import 'package:mc426_front/home/home.dart';
import 'package:mc426_front/injection/injection.dart';
import 'package:mc426_front/notifications/notifications.dart';
import 'package:mc426_front/profile/profile.dart';
import 'package:mc426_front/storage/storage.dart';

import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupProviders();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final messaging = FirebaseMessaging.instance;

  await messaging.requestPermission();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget? body;

  Future<Widget> buildHome() async {
    await initializeStorage();
    final storage = GetIt.instance.get<StorageShared>();
    if (storage.getString(userIdKey) != null && storage.getString(userIdKey) != "logged_out") const HomePage();
    return const SignInPage();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      body = await buildHome();
      setState(() {});
    });
  }

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
        UserPostsPage.routeName: (context) => const UserPostsPage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        HomePage.routeName: (context) => const HomePage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        SignInPage.routeName: (context) => const SignInPage(),
        NotificationsPage.routeName: (context) => const NotificationsPage(),
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
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          iconSize: 24,
          backgroundColor: Color(0xFFC53D46),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
      ),
      home: body ?? const Center(child: CircularProgressIndicator()),
    );
  }
}
