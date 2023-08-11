import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'settings.db');

    return await openDatabase(dbPath, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE settings(     
        name TEXT,
        nachName TEXT,
        strasse TEXT,
        hausnummer TEXT,
        plz TEXT,
        ort TEXT,
        steuernummer TEXT,
        iban TEXT,
        bic TEXT,
        websiteUrl TEXT,
        telefonNummer TEXT,
        email TEXT 
       
      )
    ''');

    await db.execute('''
      CREATE TABLE invoiceNumbers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        invoice_number INTEGER
      )
    ''');
  }

  // Insert method for adding a new invoice and incrementing the invoice_number
  Future<int> insertInvoice() async {
    Database db = await instance.database;

    // Get the current highest invoice number
    List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT MAX(invoice_number) FROM invoiceNumbers');
    int currentInvoiceNumber = (result.first.values.first ?? 0) + 1;
    return currentInvoiceNumber;
  }

  Future<int> insertInvoiceNumber(currentInvoiceNumber) async {
    Database db = await instance.database;
    // Insert the new invoice with the incremented invoice number
    return await db.rawInsert('INSERT INTO Invoice (invoice_number) VALUES (?)',
        [currentInvoiceNumber]);
  }

  // // Query method to get all invoices
  // Future<List<Map<String, dynamic>>> queryAllInvoices() async {
  //   Database db = await instance.database;
  //   return await db.query('Invoice');
  // }

  Future<int> insertSettings(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('settings', row);
  }

  Future<List<Map<String, dynamic>>> getAllSettings() async {
    Database db = await instance.database;
    return await db.query('settings');
  }
}
