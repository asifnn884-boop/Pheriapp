import 'package:flutter/material.dart';
import '../database/evening_helper.dart';
import '../database/stock_helper.dart';
import '../database/scrap_helper.dart';

class EveningEntryUI extends StatefulWidget {
  @override
  _EveningEntryUIState createState() => _EveningEntryUIState();
}

class _EveningEntryUIState extends State<EveningEntryUI> {
  final eveningHelper = EveningHelper();
  final stockHelper = StockHelper();
  final scrapHelper = ScrapHelper();

  List<Map<String, dynamic>> stockList = [];
  Map<int, TextEditingController> quantityControllers = {};
  TextEditingController cashController = TextEditingController();
  TextEditingController scrapWeightController = TextEditingController();

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

  void saveEveningEntry() async {
    String date = DateTime.now().toString().split(' ')[0];

    for (var item in stockList) {
      int quantityLeft = int.tryParse(quantityControllers[item['id']]?.text ?? '') ?? 0;
      await eveningHelper.insertEvening({
        'item_name': item['item_name'],
        'quantity_left': quantityLeft,
        'cash_received': double.tryParse(cashController.text) ?? 0.0,
        'scrap_weight': double.tryParse(scrapWeightController.text) ?? 0.0,
        'date': date,
      });
    }

    cashController.clear();
    scrapWeightController.clear();
    fetchStock();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Evening entry saved')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('شام کی انٹری')),
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
                        decoration: InputDecoration(labelText: 'بچی مقدار'),
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
            TextField(
              controller: scrapWeightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'سکریپ وزن'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: saveEveningEntry,
              child: Text('Save Evening Entry'),
            ),
          ],
        ),
      ),
    );
  }
}
