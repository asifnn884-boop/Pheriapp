import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class ScrapHelper {
  final dbHelper = DBHelper();

  // سکریپ ایڈ کرنا
  Future<int> insertScrap(Map<String, dynamic> row) async {
    final db = await dbHelper.database;
    return await db.insert('scrap_table', row);
  }

  // تمام سکریپ ڈیٹا پڑھنا
  Future<List<Map<String, dynamic>>> getAllScrap() async {
    final db = await dbHelper.database;
    return await db.query('scrap_table');
  }

  // سکریپ اپڈیٹ کرنا
  Future<int> updateScrap(Map<String, dynamic> row, int id) async {
    final db = await dbHelper.database;
    return await db.update(
      'scrap_table',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // سکریپ ڈیلیٹ کرنا
  Future<int> deleteScrap(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'scrap_table',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ٹوٹل رقم نکالنے کا function
  Future<double> getTotalAmount() async {
    final db = await dbHelper.database;
    final result = await db.rawQuery('SELECT SUM(total) as totalAmount FROM scrap_table');
    return result.first['totalAmount'] as double? ?? 0.0;
  }
}
