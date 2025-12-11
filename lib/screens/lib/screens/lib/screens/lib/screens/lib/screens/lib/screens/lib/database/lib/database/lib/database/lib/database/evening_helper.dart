import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class EveningHelper {
  final dbHelper = DBHelper();

  // ایوننگ انٹری ایڈ کرنا
  Future<int> insertEvening(Map<String, dynamic> row) async {
    final db = await dbHelper.database;
    return await db.insert('evening_entry_table', row);
  }

  // تمام ایوننگ انٹری پڑھنا
  Future<List<Map<String, dynamic>>> getAllEvening() async {
    final db = await dbHelper.database;
    return await db.query('evening_entry_table');
  }

  // ایوننگ انٹری اپڈیٹ کرنا
  Future<int> updateEvening(Map<String, dynamic> row, int id) async {
    final db = await dbHelper.database;
    return await db.update(
      'evening_entry_table',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ایوننگ انٹری ڈیلیٹ کرنا
  Future<int> deleteEvening(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'evening_entry_table',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ٹوٹل سیل اور منافع نکالنے کے لیے example function
  Future<double> getTotalProfit() async {
    final db = await dbHelper.database;
    final result = await db.rawQuery('''
      SELECT SUM((cash_received + scrap_weight * 0.0) - 0.0) as profit
      FROM evening_entry_table
    ''');
    return result.first['profit'] as double? ?? 0.0;
  }
}
