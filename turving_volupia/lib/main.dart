import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
        primaryColorDark: Colors.red.shade900,
      ),
      darkTheme: ThemeData.dark(),
    );
  }
}
