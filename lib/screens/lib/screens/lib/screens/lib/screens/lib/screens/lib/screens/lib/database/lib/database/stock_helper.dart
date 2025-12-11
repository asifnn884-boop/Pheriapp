import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class StockHelper {
  final dbHelper = DBHelper();

  // اسٹاک میں چیز ایڈ کرنا
  Future<int> insertStock(Map<String, dynamic> row) async {
    final db = await dbHelper.database;
    return await db.insert('stock_table', row);
  }

  // تمام اسٹاک چیزیں پڑھنا
  Future<List<Map<String, dynamic>>> getAllStock() async {
    final db = await dbHelper.database;
    return await db.query('stock_table');
  }

  // اسٹاک چیز اپڈیٹ کرنا
  Future<int> updateStock(Map<String, dynamic> row, int id) async {
    final db = await dbHelper.database;
    return await db.update(
      'stock_table',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // اسٹاک چیز ڈیلیٹ کرنا
  Future<int> deleteStock(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'stock_table',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
