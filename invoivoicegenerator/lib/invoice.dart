import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InvoicePage extends StatelessWidget {
  final Key? invoicepagekey; // Add a named key parameter

  const InvoicePage({Key? key, this.invoicepagekey}) : super(key: key);
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
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nachname'),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
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
                      decoration: const InputDecoration(labelText: 'PLZ'),
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
                  border:
                      Border.all(color: Colors.blue), // Customize the border
                  borderRadius:
                      BorderRadius.circular(8.0), // Customize the corner radius
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
                  border:
                      Border.all(color: Colors.blue), // Customize the border
                  borderRadius:
                      BorderRadius.circular(8.0), // Customize the corner radius
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
                  border:
                      Border.all(color: Colors.blue), // Customize the border
                  borderRadius:
                      BorderRadius.circular(8.0), // Customize the corner radius
                ),
                child: const TextField(
                  maxLines: null,
                  decoration: InputDecoration(labelText: 'Position 3'),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Add your button click logic here
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
