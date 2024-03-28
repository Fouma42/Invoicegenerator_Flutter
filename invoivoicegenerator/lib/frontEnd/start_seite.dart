import 'package:flutter/material.dart';
import '../backEnd/settings_page_logic.dart';
import 'package:invoivoicegenerator/invoice.dart';
import '../database_helper.dart';
import '../frontEnd/add_new_user.dart';
import '../frontEnd/settings_page.dart';

class StartSeite extends StatefulWidget {
  const StartSeite({Key? key}) : super(key: key);
  @override
  State<StartSeite> createState() => _StartSeiteState();
}

class _StartSeiteState extends State<StartSeite> {
  late Future<bool> _userIsAvailable;

  @override
  void initState() {
    super.initState();
    _loadUserAvailability();
  }

  Future<void> _loadUserAvailability() async {
    SettingsPageLogic logic = SettingsPageLogic();
    setState(() {
      _userIsAvailable = logic.userAvailabel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<bool>(
          future: _userIsAvailable,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            } else {
              return Text(snapshot.data == true
                  ? 'Bitte Wählen Sie eine Option'
                  : 'Hallo schön das du da bist.');
            }
          },
        ),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<bool>(
          future: _userIsAvailable,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.data == true) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      navigateToAddNewUserPage();
                    },
                    child: const Text('Weiteren User anlagen'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      navigateToUserPage();
                    },
                    child: const Text('Rechnung erstellen'),
                  ),
                ],
              );
            } else {
              return ElevatedButton(
                onPressed: () {
                  navigateToAddNewUserPage();
                },
                child: const Text('User anlegen'),
              );
            }
          },
        ),
      ),
    );
  }

  navigateToInvoicePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InvoicePage()),
    );
  }

  navigateToAddNewUserPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewUserPage()),
    );
  }

  navigateToUserPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  }
}
