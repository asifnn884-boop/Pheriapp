import 'package:flutter/material.dart';
import '../database/stock_helper.dart';

class StockScreenUI extends StatefulWidget {
  @override
  _StockScreenUIState createState() => _StockScreenUIState();
}

class _StockScreenUIState extends State<StockScreenUI> {
  final stockHelper = StockHelper();
  List<Map<String, dynamic>> stockList = [];

  TextEditingController itemController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController buyRateController = TextEditingController();
  TextEditingController sellRateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchStock();
  }

  void fetchStock() async {
    final data = await stockHelper.getAllStock();
    setState(() {
      stockList = data;
    });
  }

  void addStock() async {
    if (itemController.text.isEmpty) return;
    await stockHelper.insertStock({
      'item_name': itemController.text,
      'quantity': int.tryParse(quantityController.text) ?? 0,
      'buy_rate': double.tryParse(buyRateController.text) ?? 0.0,
      'sell_rate': double.tryParse(sellRateController.text) ?? 0.0,
    });
    itemController.clear();
    quantityController.clear();
    buyRateController.clear();
    sellRateController.clear();
    fetchStock();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('اسٹاک مینجمنٹ')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: itemController,
              decoration: InputDecoration(labelText: 'چیز کا نام'),
            ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'مقدار'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: buyRateController,
              decoration: InputDecoration(labelText: 'خرید ریٹ'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: sellRateController,
              decoration: InputDecoration(labelText: 'سیل ریٹ'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addStock,
              child: Text('چیز ایڈ کریں'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: stockList.length,
                itemBuilder: (context, index) {
                  final item = stockList[index];
                  return ListTile(
                    title: Text(item['item_name']),
                    subtitle: Text(
                        'Quantity: ${item['quantity']}, Buy: ${item['buy_rate']}, Sell: ${item['sell_rate']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
