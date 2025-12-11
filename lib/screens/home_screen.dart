import 'package:flutter/material.dart';
import 'morning_entry_screen.dart';
import 'evening_entry_screen.dart';
import 'stock_screen.dart';
import 'scrap_screen.dart';
import 'reports_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('پھیری ایپ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('اسٹاک'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StockScreen()),
                );
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('صبح کی انٹری'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MorningEntryScreen()),
                );
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('شام کی انٹری'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EveningEntryScreen()),
                );
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('سکریپ'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScrapScreen()),
                );
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('رپورٹس'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
