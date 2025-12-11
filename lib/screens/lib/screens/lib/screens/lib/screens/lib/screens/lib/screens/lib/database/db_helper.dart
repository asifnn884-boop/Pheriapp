import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'pherii.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // اسٹاک ٹیبل
    await db.execute('''
      CREATE TABLE stock_table(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_name TEXT,
        quantity INTEGER,
        buy_rate REAL,
        sell_rate REAL
      )
    ''');

    // مورنگ انٹری ٹیبل
    await db.execute('''
      CREATE TABLE morning_entry_table(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_name TEXT,
        quantity_taken INTEGER,
        cash_taken REAL,
        date TEXT
      )
    ''');

    // ایوننگ انٹری ٹیبل
    await db.execute('''
      CREATE TABLE evening_entry_table(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_name TEXT,
        quantity_left INTEGER,
        cash_received REAL,
        scrap_weight REAL,
        date TEXT
      )
    ''');

    // سکریپ ٹیبل
    await db.execute('''
      CREATE TABLE scrap_table(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        scrap_type TEXT,
        weight REAL,
        rate REAL,
        total REAL,
        date TEXT
      )
    ''');
  }
}
