import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoivoicegenerator/model/settings.dart';
import 'package:invoivoicegenerator/pdf_view.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../data_base/database_access_impl.dart';
import 'package:logger/logger.dart';
import '../backEnd/invoice_calcultor.dart';

class InvoiceCreationPage extends StatefulWidget {
  final String? name;
  const InvoiceCreationPage({Key? key, required this.name}) : super(key: key);

  @override
  InvoiceCreationPageState createState() => InvoiceCreationPageState();
}

class InvoiceCreationPageState extends State<InvoiceCreationPage> {
  final Logger logger = Logger();
  late Settings user;

  @override
  void initState() {
    super.initState();
    _loadUserAvailability();
  }

  Future<void> _loadUserAvailability() async {
    logger.d('Bindavor');
    logger.d(widget.name);
    DataBaseAccess dbaccess = DataBaseAccess();
    user = await dbaccess.getUserByName(widget.name);

    logger.d(user.name);
  }

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
  final int total = 0;
  final InvoiceCalculator _calculate = InvoiceCalculator();

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
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(labelText: 'Betrag'),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(labelText: 'Betrag'),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                        keyboardType:
                            TextInputType.number, // Nur Zahlen zulassen
                        textAlign:
                            TextAlign.right, // Text rechtsbündig ausrichten
                        decoration: const InputDecoration(
                          labelText: 'Betrag',
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly // Nur Zahlen zulassen
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  final File file = await _generatePDF(user);
                  logger.d(file);
                  navigateToPdfViewerPage(file);
                },
                child: const Text('PDF Erzeugen'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<File> _generatePDF(Settings user) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              //Rechnungsersteller adresse
              pw.Row(
                children: [
                  pw.Text(user.name),
                  pw.Padding(padding: const pw.EdgeInsets.only(right: 3.0)),
                  pw.Text(user.nachName),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text(user.strasse),
                  pw.Padding(padding: const pw.EdgeInsets.only(right: 3.0)),
                  pw.Text(user.hausnummer),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text(user.plz),
                  pw.Padding(padding: const pw.EdgeInsets.only(right: 3.0)),
                  pw.Text(user.ort),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text(user.telefonNummer),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text(user.email),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text(user.websiteUrl),
                ],
              ),

              //Ab hier kundenadresse
              pw.Padding(padding: const pw.EdgeInsets.only(top: 60.0)),
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
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 150.0),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(
                    10.0), // Fügen Sie hier das gewünschte Padding hinzu
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),

                  borderRadius:
                      pw.BorderRadius.circular(10.0), // Radius der Ecken
                ),
                child: pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(_pos1Controller.text),
                        pw.Text(_pos1BetragController.text),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(_pos2Controller.text),
                        pw.Text(_pos2BetragController.text),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(_pos3Controller.text),
                        pw.Text(_pos3BetragController.text),
                      ],
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(10.0),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Gesamtbetrag'),
                    pw.Text(_calculate.calculateTotalAmount(
                        int.parse(_pos1BetragController.text.isEmpty
                            ? '0'
                            : _pos1BetragController.text),
                        int.parse(_pos2BetragController.text.isEmpty
                            ? '0'
                            : _pos2BetragController.text),
                        int.parse(_pos3BetragController.text.isEmpty
                            ? '0'
                            : _pos3BetragController.text))),
                  ],
                ),
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

  navigateToPdfViewerPage(file) {
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
