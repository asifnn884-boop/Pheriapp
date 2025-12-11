import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('رپورٹس'),
      ),
      body: Center(
        child: Text(
          'یہاں روزانہ، ہفتہ وار، ماہانہ رپورٹس اور منافع/نقصان دکھیں گے',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
