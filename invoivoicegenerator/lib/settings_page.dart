import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
 State<SettingsPage>createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nachNameController = TextEditingController();
  final TextEditingController _strasseController = TextEditingController();
  final TextEditingController _hausNummerController = TextEditingController();
  final TextEditingController _ortController = TextEditingController();
  final TextEditingController _plzController = TextEditingController();
  final TextEditingController _telefonnummerController =
      TextEditingController();
  final TextEditingController _websiteUrlController = TextEditingController();
  final TextEditingController _steuernummerController = TextEditingController();
  final TextEditingController _ibanController = TextEditingController();
  final TextEditingController _bicController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();


  void _saveSettings() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text.trim();
      String nachName = _nachNameController.text.trim();
      String strasse = _strasseController.text.trim();
      String hausnummer = _hausNummerController.text.trim();
      String ort = _ortController.text.trim();
      String plz = _plzController.text.trim();
      String telefonNummer = _telefonnummerController.text.trim();
      String websiteUrl = _websiteUrlController.text.trim();
      String steuernummer = _steuernummerController.text.trim();
      String iban = _ibanController.text.trim();
      String bic = _bicController.text.trim();
      String email = _emailController.text.trim();
      

      Map<String, dynamic> settings = {
        'name': name,
        'nachName': nachName,
        'strasse':strasse,
        'hausnummer':hausnummer,
        'plz':plz,
        'ort':ort,
        'steuernummer':steuernummer,
        'iban': iban,
        'bic': bic,
        'websiteUrl':websiteUrl,
        'telefonNummer':telefonNummer,
        'email': email,        
      };

      await DatabaseHelper.instance.insertSettings(settings);

      
      // Show a SnackBar or navigate to another page to indicate success.
  Fluttertoast.showToast(
        msg: "Ihre Daten wurden erfolgreich gespeichert",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bitte geben Sie Ihren Namen ein';
                  }
                  return null;
                },
              ),
                  TextFormField(
                controller: _nachNameController,
                decoration: const InputDecoration(labelText: 'Nachname'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bitte geben Sie Ihren Nachnamen ein';
                  }
                  return null;
                },
              ),
                
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _strasseController,
                      decoration: const InputDecoration(labelText: 'Straße'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Bitte geben Sie Ihre Straße ein';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16), 
                  Expanded(
                    child: TextFormField(
                      controller: _hausNummerController,
                      decoration: const InputDecoration(labelText: 'Hausnummer'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Bitte geben Sie Ihre Hausnummer ein';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
  
              Row(
                children: [
                  Expanded(
                    child:  TextFormField(
                controller: _plzController,
                decoration: const InputDecoration(labelText: 'PLZ'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bitte geben Sie Ihre PLZ ein';
                  }
                  return null;
                },
              ),
                  ),
                 const  SizedBox(width: 16),
                  Expanded(
                    child:             TextFormField(
                controller: _ortController,
                decoration: const InputDecoration(labelText: 'Ort'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bitte geben Sie Ihren Ort ein';
                  }
                  return null;
                },
              ),
                  ),
                ],
              ),     
                  TextFormField(
                controller: _telefonnummerController,
                decoration: const InputDecoration(labelText: 'Telefonnummer'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bitte geben Sie Ihre Telefonnummer ein';
                  }
                  return null;
                },
              ),
                  TextFormField(
                controller: _steuernummerController,
                decoration: const InputDecoration(labelText: 'Steuernummer'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bitte geben Sie Ihre Steuernummer ein';
                  }
                  return null;
                },
              ),
                  TextFormField(
                controller: _ibanController,
                decoration: const InputDecoration(labelText: 'IBAN'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bitte geben Sie Ihre IBAN ein';
                  }
                  return null;
                },
              ),
                  TextFormField(
                controller: _bicController,
                decoration: const InputDecoration(labelText: 'BIC'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bitte geben Sie Ihre BIC ein';
                  }
                  return null;
                },
              ),
                  TextFormField(
                controller: _websiteUrlController,
                decoration: const InputDecoration(labelText: 'Website URL'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bitte geben Sie Ihre Website URL ein fals vorhanden';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bitte geben Sie Ihre E-Mail ein';
                  }
                  return null;
                },
              ),
          
             const  SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveSettings,
                child: const Text('Save Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
