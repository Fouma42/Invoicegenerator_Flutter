import 'package:flutter/material.dart';
import 'package:invoivoicegenerator/pdf_view.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'database_helper.dart';
import 'dart:developer';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key? key}) : super(key: key);

  @override
  InvoicePageState createState() => InvoicePageState();
}

class InvoicePageState extends State<InvoicePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nachnameController = TextEditingController();
  final TextEditingController _strasseController = TextEditingController();
  final TextEditingController _hausnummerController = TextEditingController();
  final TextEditingController _plzController = TextEditingController();
  final TextEditingController _ortController = TextEditingController();
  final TextEditingController _pos1Controller = TextEditingController();
  final TextEditingController _pos2Controller = TextEditingController();
  final TextEditingController _pos3Controller = TextEditingController();
  final TextEditingController _pos1BetragController = TextEditingController();
  final TextEditingController _pos2BetragController = TextEditingController();
  final TextEditingController _pos3BetragController = TextEditingController();
  String userName = "";
  String userSurnName = "";
  String userStreet = "";
  String userNumber = "";
  String userPLZ = "";
  String userOrt = "";
  String useSteuernummer = "";
  String userIban = "";
  String userBIC = "";
  String userWebUrl = "";
  String userTelefon = "";
  String userEmail = "";

  Future<File> _generatePDF() async {
    final DatabaseHelper dbHelper = DatabaseHelper.instance;
    List<Map<String, dynamic>> settingsList = await dbHelper.getAllSettings();

    // Ausgabe der abgerufenen Einstellungen
    for (var settings in settingsList) {
      userName = settings['name'];
      userSurnName = settings['nachName'];
      userStreet = settings['strasse'];
      userNumber = settings['hausnummer'];
      userPLZ = settings['plz'];
      userOrt = settings['ort'];
      useSteuernummer = settings['steuernummer'];
      userIban = settings['iban'];
      userBIC = settings['bic'];
      userWebUrl = settings['websiteUrl'];
      userTelefon = settings['telefonNummer'];
      userEmail = settings['email'];
      log('bin in for');
      log(useSteuernummer);
      stderr.writeln('print me');
    }

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              //Rechnungsersteller adresse
              pw.Row(
                children: [
                  pw.Text(userName),
                  pw.Padding(padding: const pw.EdgeInsets.only(right: 3.0)),
                  pw.Text(userSurnName),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text(userStreet),
                  pw.Padding(padding: const pw.EdgeInsets.only(right: 3.0)),
                  pw.Text(userNumber),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text(userPLZ),
                  pw.Padding(padding: const pw.EdgeInsets.only(right: 3.0)),
                  pw.Text(userOrt),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text(userTelefon),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text(userEmail),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text(userWebUrl),
                ],
              ),

              //Ab hier kundenadresse
              pw.Padding(padding: const pw.EdgeInsets.only(top: 25.0)),
              pw.Row(
                children: [
                  pw.Text(_nameController.text),
                  pw.Padding(padding: const pw.EdgeInsets.only(right: 3.0)),
                  pw.Text(_nachnameController.text),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text(_strasseController.text),
                  pw.Padding(padding: const pw.EdgeInsets.only(right: 3.0)),
                  pw.Text(_hausnummerController.text),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text(_plzController.text),
                  pw.Padding(padding: const pw.EdgeInsets.only(right: 3.0)),
                  pw.Text(_ortController.text),
                ],
              ),

              pw.Row(
                children: [
                  pw.Text(_pos1Controller.text),
                  pw.Padding(padding: const pw.EdgeInsets.only(right: 3.0)),
                  pw.Text(_pos1BetragController.text),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text(_pos2Controller.text),
                  pw.Padding(padding: const pw.EdgeInsets.only(right: 3.0)),
                  pw.Text(_pos2BetragController.text),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text(_pos3Controller.text),
                  pw.Padding(padding: const pw.EdgeInsets.only(right: 3.0)),
                  pw.Text(_pos3BetragController.text),
                ],
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/invoice.pdf');
    await file.writeAsBytes(await pdf.save());
    // Fluttertoast.showToast(msg: 'PDF erstellt: ${file.path}');
    return file;
  }

  gotTo(file) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerPage(
          pdfPath: file.path,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rechnungsdaten')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _nachnameController,
                decoration: const InputDecoration(labelText: 'Nachname'),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _strasseController,
                      decoration: const InputDecoration(labelText: 'Strasse'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Strasse';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _hausnummerController,
                      decoration:
                          const InputDecoration(labelText: 'Hausnummer'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Hausnummer';
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
                    child: TextFormField(
                      controller: _plzController,
                      decoration: const InputDecoration(labelText: 'PLZ'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'PLZ';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _ortController,
                      decoration: const InputDecoration(labelText: 'Ort'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ort';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
              ),
              Row(
                children: [
                  Expanded(
                    flex:
                        4, // Erstes Textfeld ist doppelt so breit wie das zweite
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextField(
                        controller: _pos1Controller,
                        decoration:
                            const InputDecoration(labelText: 'Position 1'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Abstand zwischen den Containern
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextField(
                        controller: _pos1BetragController,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(labelText: 'Betrag'),
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
              ),
              Row(
                children: [
                  Expanded(
                    flex:
                        4, // Erstes Textfeld ist doppelt so breit wie das zweite
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextField(
                        controller: _pos2Controller,
                        decoration:
                            const InputDecoration(labelText: 'Position 2'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Abstand zwischen den Containern
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextField(
                        controller: _pos2BetragController,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(labelText: 'Betrag'),
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
              ),
              Row(
                children: [
                  Expanded(
                    flex:
                        4, // Erstes Textfeld ist doppelt so breit wie das zweite
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextField(
                        controller: _pos3Controller,
                        decoration:
                            const InputDecoration(labelText: 'Position 3'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Abstand zwischen den Containern
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextField(
                        controller: _pos3BetragController,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(labelText: 'Betrag'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  // Capture the BuildContext outside the async block
                  final File file = await _generatePDF();

                  // Use the captured BuildContext inside the async block

                  gotTo(file);
                },
                child: const Text('Save Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is removed from the tree
    _nameController.dispose();
    _nachnameController.dispose();
    _strasseController.dispose();
    _hausnummerController.dispose();
    _plzController.dispose();
    _ortController.dispose();
    _pos1Controller.dispose();
    _pos2Controller.dispose();
    _pos3Controller.dispose();
    _pos1BetragController.dispose();
    _pos2BetragController.dispose();
    _pos3BetragController.dispose();
    super.dispose();
  }
}
