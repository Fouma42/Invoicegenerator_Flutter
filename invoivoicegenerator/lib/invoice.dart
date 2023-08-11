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

  Future<File> _generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.Text('Rechnungsdaten'),
                pw.Text('Name: ${_nameController.text}'),
                pw.Text('Nachname: ${_nachnameController.text}'),
                // ... Weitere Texte basierend auf den Controllern
              ],
            ),
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
    gotTo(file){
          Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerPage(
          pdfPath:  file.path,
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
                child: const TextField(
                  maxLines: null,
                  decoration: InputDecoration(labelText: 'Position 1'),
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
                child: const TextField(
                  maxLines: null,
                  decoration: InputDecoration(labelText: 'Position 2'),
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
                child: const TextField(
                  maxLines: null,
                  decoration: InputDecoration(labelText: 'Position 3'),
                ),
              ),
              const SizedBox(height: 16.0),
              
            ElevatedButton(
  onPressed: () async {
    // Capture the BuildContext outside the async block


    // Access the text from the controllers
    String name = _nameController.text;
    String nachname = _nachnameController.text;
    String strasse = _strasseController.text;
    String hausnummer = _hausnummerController.text;
    String plz = _plzController.text;
    String ort = _ortController.text;

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
