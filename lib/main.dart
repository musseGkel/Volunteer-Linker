import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'features/auth/presentation/pages/routing_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volunteer Linker',
      home: const RoutingPage(),
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle?>(
              const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
