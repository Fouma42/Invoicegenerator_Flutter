import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invoivoicegenerator/pdf_view.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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

  Future<File> _generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              //Rechnungsersteller adresse
              pw.Row(
                children: [
                  pw.Text("Name"),
                  pw.Padding(padding: const pw.EdgeInsets.only(right: 3.0)),
                  pw.Text("Nachname"),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text("Strasse"),
                  pw.Padding(padding: const pw.EdgeInsets.only(right: 3.0)),
                  pw.Text("Hausnummer"),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text("PLZ"),
                  pw.Padding(padding: const pw.EdgeInsets.only(right: 3.0)),
                  pw.Text("ORT"),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text("Telefon"),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text("E-Mail"),
                ],
              ),
              pw.Row(
                children: [
                  pw.Text("Webadresse"),
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
    super.dispose();
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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _pos1Controller,
                  decoration: const InputDecoration(labelText: 'Position 1'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _pos2Controller,
                  decoration: const InputDecoration(labelText: 'Position 2'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _pos3Controller,
                  decoration: const InputDecoration(labelText: 'Position 3'),
                ),
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
}
