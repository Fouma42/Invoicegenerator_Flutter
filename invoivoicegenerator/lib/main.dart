import 'package:flutter/material.dart';
import 'frontEnd/settings_page.dart';
import 'database_helper.dart';
import 'frontEnd/add_new_user.dart';
import '../frontEnd/start_seite.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that the Flutter engine is initialized
  bool settingsAvailable = await DatabaseHelper.instance.settingsAvailable();

  runApp(MyApp(settingsAvailable: settingsAvailable));
}

class MyApp extends StatelessWidget {
  final bool settingsAvailable;

  const MyApp({Key? key, required this.settingsAvailable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invoice Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: settingsAvailable ? const InvoicePage() : const SettingsPage(),
      home: const StartSeite(),
    );
  }
}
