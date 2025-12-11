import 'package:flutter/material.dart';

class StockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اسٹاک مینجمنٹ'),
      ),
      body: Center(
        child: Text(
          'یہاں اسٹاک کی تمام چیزیں دکھیں گی اور ایڈ/ایڈٹ کی جا سکیں گی',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
