import 'package:flutter/material.dart';
import 'package:invoivoicegenerator/model/settings.dart';
import '../backEnd/database_access_impl.dart';
import 'package:invoivoicegenerator/invoice.dart';
import '../frontEnd/settings_page.dart';
import 'package:logger/logger.dart';

class UserSelection extends StatefulWidget {
  final List<String> options;

  const UserSelection({Key? key, required this.options}) : super(key: key);

  @override
  State<UserSelection> createState() => _UserSelectionState(options);
}

class _UserSelectionState extends State<UserSelection> {
  late Future<bool> _userIsAvailable;
  late Future<int?> _userCount;
  late Future<Settings> _user;
  String? _selectedName;
  late List<String> _options;
  final Logger logger = Logger();

  _UserSelectionState(this._options);

  @override
  void initState() {
    super.initState();
    _loadUserAvailability();
  }

  Future<void> _loadUserAvailability() async {
    DataBaseAccess logic = DataBaseAccess();
    setState(() {
      _userIsAvailable = logic.userAvailabel();
      _userCount = logic.getUserCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5.0, top: 150),
            alignment: Alignment.center,
            child: const Text(
              'Mit welchem User soll die Rechnung erstellt werden?',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 150),
            child: DropdownButtonFormField<String>(
              padding: const EdgeInsets.all(14.0),
              value: _selectedName,
              items: _options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedName = newValue;
                });
              },
              decoration: const InputDecoration(
                  labelText: 'Username', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null) {
                  return 'Bitte wählen Sie Ihren Namen aus';
                }
                return null;
              },
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 80)),
          ElevatedButton(
            onPressed: () async {
              navigateToInvoicePage();
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                  const Size(180, 60)), // Ändere die Größe hier
              padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
              // Optional: Ändere das Padding
            ),
            child: const Text(
              'ÜBERNEHMEN',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ),
        ],
      )),
    );
  }

  navigateToInvoicePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => InvoicePage(
                name: _selectedName,
              )),
    );
  }

  navigateToUserPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  }
}
