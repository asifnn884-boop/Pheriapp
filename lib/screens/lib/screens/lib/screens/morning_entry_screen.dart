import 'package:flutter/material.dart';

class MorningEntryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صبح کی انٹری'),
      ),
      body: Center(
        child: Text(
          'یہاں صبح کے وقت ساتھ لی جانے والی چیزیں اور جیب کے پیسے ڈالے جائیں گے',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
