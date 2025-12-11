import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class ReportsHelper {
  final dbHelper = DBHelper();

  // روزانہ رپورٹ
  Future<List<Map<String, dynamic>>> getDailyReport(String date) async {
    final db = await dbHelper.database;
    final morning = await db.query(
      'morning_entry_table',
      where: 'date = ?',
      whereArgs: [date],
    );
    final evening = await db.query(
      'evening_entry_table',
      where: 'date = ?',
      whereArgs: [date],
    );
    final scrap = await db.query(
      'scrap_table',
      where: 'date = ?',
      whereArgs: [date],
    );

    return [
      {'morning': morning, 'evening': evening, 'scrap': scrap}
    ];
  }

  // ہفتہ وار رپورٹ
  Future<List<Map<String, dynamic>>> getWeeklyReport(String startDate, String endDate) async {
    final db = await dbHelper.database;

    final morning = await db.rawQuery(
      'SELECT * FROM morning_entry_table WHERE date BETWEEN ? AND ?',
      [startDate, endDate],
    );
    final evening = await db.rawQuery(
      'SELECT * FROM evening_entry_table WHERE date BETWEEN ? AND ?',
      [startDate, endDate],
    );
    final scrap = await db.rawQuery(
      'SELECT * FROM scrap_table WHERE date BETWEEN ? AND ?',
      [startDate, endDate],
    );

    return [
      {'morning': morning, 'evening': evening, 'scrap': scrap}
    ];
  }

  // ٹوٹل منافع/نقصان کیلکولیشن
  Future<double> getProfit(String date) async {
    final db = await dbHelper.database;
    final evening = await db.query(
      'evening_entry_table',
      where: 'date = ?',
      whereArgs: [date],
    );
    final scrap = await db.query(
      'scrap_table',
      where: 'date = ?',
      whereArgs: [date],
    );

    double totalCash = 0.0;
    double totalScrap = 0.0;

    for (var row in evening) {
      totalCash += (row['cash_received'] as double? ?? 0.0);
    }
    for (var row in scrap) {
      totalScrap += (row['total'] as double? ?? 0.0);
    }

    return totalCash + totalScrap;
  }
}
