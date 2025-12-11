import 'package:flutter/material.dart';

class EveningEntryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('شام کی انٹری'),
      ),
      body: Center(
        child: Text(
          'یہاں شام کے وقت بچی ہوئی چیزیں، بیچی ہوئی چیزیں، سکریپ اور نقد رقم ڈالیں گے',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
