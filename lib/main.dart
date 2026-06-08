import 'package:chat_chit_flutter/screens/auth_screen.dart';
import 'package:flutter/material.dart';

final theme = ThemeData().copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 63, 17, 177),
  ),
);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "ChatChit", theme: theme, home: AuthScreen());
  }
}
