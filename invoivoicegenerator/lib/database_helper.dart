import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/settings.dart';

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
        steuernummer TEXT PRIMARY KEY,   
        name TEXT,
        nachName TEXT,
        strasse TEXT,
        hausnummer TEXT,
        plz TEXT,
        ort TEXT,
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
    //await db.delete('settings');
    return await db.insert('settings', row);
  }

  Future<List<Map<String, dynamic>>> getAllSettings() async {
    Database db = await instance.database;
    return await db.query('settings');
  }

  Future<List<Settings>> getUsers() async {
    final List<Map<String, dynamic>> maps = await _database!.query('settings');

    return List.generate(maps.length, (i) {
      return Settings(
        steuernummer: maps[i]['steuernummer'],
        nachName: maps[i]['nachName'],
        name: maps[i]['name'],
        strasse: maps[i]['strasse'],
        hausnummer: maps[i]['hausnummer'],
        plz: maps[i]['plz'],
        ort: maps[i]['ort'],
        iban: maps[i]['iban'],
        bic: maps[i]['bic'],
        websiteUrl: maps[i]['websiteUrl'],
        telefonNummer: maps[i]['telefonNummer'],
        email: maps[i]['email'],
      );
    });
  }

  Future<bool> settingsAvailable() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> settingsList = await db.query('settings');
    return settingsList
        .isNotEmpty; // Gibt true zurück, wenn Einstellungen vorhanden sind, sonst false
  }
}
