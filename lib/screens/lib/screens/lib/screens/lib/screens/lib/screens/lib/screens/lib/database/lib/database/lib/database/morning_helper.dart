import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class MorningHelper {
  final dbHelper = DBHelper();

  // مورنگ انٹری ایڈ کرنا
  Future<int> insertMorning(Map<String, dynamic> row) async {
    final db = await dbHelper.database;
    return await db.insert('morning_entry_table', row);
  }

  // تمام مورنگ انٹری پڑھنا
  Future<List<Map<String, dynamic>>> getAllMorning() async {
    final db = await dbHelper.database;
    return await db.query('morning_entry_table');
  }

  // مورنگ انٹری اپڈیٹ کرنا
  Future<int> updateMorning(Map<String, dynamic> row, int id) async {
    final db = await dbHelper.database;
    return await db.update(
      'morning_entry_table',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // مورنگ انٹری ڈیلیٹ کرنا
  Future<int> deleteMorning(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'morning_entry_table',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
