import 'package:flutter/material.dart';
import 'package:invoivoicegenerator/frontEnd/user_selection.dart';
import '../backEnd/database_access_impl.dart';
import 'package:invoivoicegenerator/invoice.dart';
import '../frontEnd/settings_page.dart';
import 'package:logger/logger.dart';

class StartSeite extends StatefulWidget {
  const StartSeite({Key? key}) : super(key: key);
  @override
  State<StartSeite> createState() => _StartSeiteState();
}

class _StartSeiteState extends State<StartSeite> {
  late Future<bool> _userIsAvailable;
  late Future<int?> _userCount;
  late Future<List<String>> _userNames;
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    _loadUserAvailability();
  }

  Future<void> _loadUserAvailability() async {
    DataBaseAccess dbAccess = DataBaseAccess();
    setState(() {
      _userIsAvailable = dbAccess.userAvailabel();
      _userCount = dbAccess.getUserCount();
      _userNames = dbAccess.getUserNames();

      _userNames.then((List<String> userList) {
        logger.d(userList.length);
      }).catchError((error) {
        logger.e('Fehler beim Abrufen der Benutzernamen: $error');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 250, bottom: 50), // Anpassen des Abstands nach Bedarf
              child: FutureBuilder<bool>(
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
            ),
            FutureBuilder<bool>(
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
                          navigateToUserPage();
                        },
                        child: const Text('Weiteren User anlegen'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          _loadUserAvailability();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return FutureBuilder<int?>(
                                future: _userCount,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    if (snapshot.data! > 1) {
                                      return FutureBuilder<List<String>>(
                                        future: _userNames,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            return UserSelection(
                                                options: snapshot.data ?? []);
                                          }
                                        },
                                      );
                                    } else {
                                      final int? userCount = snapshot.data;
                                      logger
                                          .d('Anzahl der Benutzer: $userCount');
                                      return const SettingsPage();
                                    }
                                  }
                                },
                              );
                            }),
                          );
                        },
                        child: const Text('Rechnung erstellen'),
                      ),
                    ],
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      navigateToUserPage();
                    },
                    child: const Text('User anlegen'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  navigateToUserPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  }
}
