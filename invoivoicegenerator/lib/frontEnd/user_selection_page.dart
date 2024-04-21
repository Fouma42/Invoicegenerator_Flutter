import 'package:flutter/material.dart';
import 'package:invoivoicegenerator/data_base/database_access_impl.dart';
import 'package:invoivoicegenerator/frontEnd/add_new_user.dart';
import 'package:invoivoicegenerator/model/settings.dart';

import 'package:invoivoicegenerator/frontEnd/invoice_creation_page.dart';

import 'package:logger/logger.dart';

class UserSelectionPage extends StatefulWidget {
  final List<String> options;

  const UserSelectionPage({Key? key, required this.options}) : super(key: key);

  @override
  State<UserSelectionPage> createState() => _UserSelectionPageState();
}

class _UserSelectionPageState extends State<UserSelectionPage> {
  late Future<bool> _userIsAvailable;
  late Future<int?> _userCount;
  late Future<Settings> _user;
  String? _selectedName;
  late List<String> _options;
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    _loadUserAvailability();
  }

  Future<void> _loadUserAvailability() async {
    DataBaseAccess logic = DataBaseAccess();
    setState(() {
      _options = widget.options;
      _selectedName = _options.first;
      _userIsAvailable = logic.userAvailabel();
      _userCount = logic.getUserCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nutzer Auswahl')),
      body: Center(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5.0, top: 150),
            alignment: Alignment.center,
            child: const Text(
              'Bitte wählen Sie einen User aus.',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 150),
            child: DropdownButtonFormField<String>(
              padding: const EdgeInsets.all(14.0),
              value: _selectedName ?? _options.first,
              items: [
                DropdownMenuItem<String>(
                  value: _options.first,
                  child: Text(
                    _options.first,
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                ..._options
                    .skip(1)
                    .map<DropdownMenuItem<String>>((String value) {
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
              ],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedName = newValue;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null) {
                  return 'Bitte wählen Sie Ihren Namen aus';
                }
                return null;
              },
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'User bearbeiten',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'User löschen',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          ElevatedButton(
            onPressed: () async {
              navigateToInvoicePage();
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                  const Size(180, 30)), // Ändere die Größe hier
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
          builder: (context) => InvoiceCreationPage(
                name: _selectedName,
              )),
    );
  }

  navigateToUserPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewUserPage()),
    );
  }
}
