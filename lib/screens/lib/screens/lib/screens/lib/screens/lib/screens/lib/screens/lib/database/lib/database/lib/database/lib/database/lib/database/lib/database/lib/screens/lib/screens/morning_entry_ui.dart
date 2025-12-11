import 'package:flutter/material.dart';
import '../database/morning_helper.dart';
import '../database/stock_helper.dart';

class MorningEntryUI extends StatefulWidget {
  @override
  _MorningEntryUIState createState() => _MorningEntryUIState();
}

class _MorningEntryUIState extends State<MorningEntryUI> {
  final morningHelper = MorningHelper();
  final stockHelper = StockHelper();

  List<Map<String, dynamic>> stockList = [];
  Map<int, TextEditingController> quantityControllers = {};
  TextEditingController cashController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchStock();
  }

  void fetchStock() async {
    final data = await stockHelper.getAllStock();
    setState(() {
      stockList = data;
      quantityControllers.clear();
      for (var item in stockList) {
        quantityControllers[item['id']] = TextEditingController();
      }
    });
  }

  void saveMorningEntry() async {
    String date = DateTime.now().toString().split(' ')[0];

    for (var item in stockList) {
      int quantityTaken = int.tryParse(quantityControllers[item['id']]?.text ?? '') ?? 0;
      if (quantityTaken > 0) {
        await morningHelper.insertMorning({
          'item_name': item['item_name'],
          'quantity_taken': quantityTaken,
          'cash_taken': double.tryParse(cashController.text) ?? 0.0,
          'date': date,
        });
      }
    }
    cashController.clear();
    fetchStock();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Morning entry saved')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('صبح کی انٹری')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: stockList.length,
                itemBuilder: (context, index) {
                  final item = stockList[index];
                  return ListTile(
                    title: Text(item['item_name']),
                    trailing: SizedBox(
                      width: 60,
                      child: TextField(
                        controller: quantityControllers[item['id']],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'مقدار'),
                      ),
                    ),
                  );
                },
              ),
            ),
            TextField(
              controller: cashController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'نقد رقم'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: saveMorningEntry,
              child: Text('Save Morning Entry'),
            ),
          ],
        ),
      ),
    );
  }
}
