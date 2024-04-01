import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:logger/logger.dart';
import 'package:printing/printing.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfPath; // Pfad zur generierten PDF-Datei

  const PdfViewerPage({required this.pdfPath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              _printPDF(context);
            },
          ),
        ],
      ),
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }

  Future<void> _printPDF(BuildContext context) async {
    final pdfContent = await _readPDFFile(pdfPath);
    if (pdfContent != null) {
      await Printing.layoutPdf(
        onLayout: (_) => pdfContent,
      );
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to read PDF file for printing.'),
        ),
      );
    }
  }

  Future<Uint8List?> _readPDFFile(String pdfPath) async {
    Logger loggger = Logger();
    try {
      final file = File(pdfPath);
      return await file.readAsBytes();
    } catch (e) {
      loggger.d('Error reading PDF file: $e');

      return null;
    }
  }
}
