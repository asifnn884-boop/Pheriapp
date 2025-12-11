import 'package:flutter/material.dart';

class ScrapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('سکریپ مینجمنٹ'),
      ),
      body: Center(
        child: Text(
          'یہاں سکریپ کے تمام ڈیٹا (قسم، وزن، ریٹ، ٹوٹل رقم) ڈالیں گے',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
