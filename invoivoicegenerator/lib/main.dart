import 'package:flutter/material.dart';
import 'settings_page.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invoice Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SettingsPage(), // Hier wird die Einstellungsseite als Startseite verwendet
    );
  }
}




