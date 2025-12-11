import 'package:flutter/material.dart';
import '../database/scrap_helper.dart';

class ScrapUI extends StatefulWidget {
  @override
  _ScrapUIState createState() => _ScrapUIState();
}

class _ScrapUIState extends State<ScrapUI> {
  final scrapHelper = ScrapHelper();

  List<Map<String, dynamic>> scrapList = [];
  TextEditingController typeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchScrap();
  }

  void fetchScrap() async {
    final data = await scrapHelper.getAllScrap();
    setState(() {
      scrapList = data;
    });
  }

  void addScrap() async {
    double weight = double.tryParse(weightController.text) ?? 0.0;
    double rate = double.tryParse(rateController.text) ?? 0.0;
    if (typeController.text.isEmpty || weight <= 0 || rate <= 0) return;

    await scrapHelper.insertScrap({
      'scrap_type': typeController.text,
      'weight': weight,
      'rate': rate,
      'total': weight * rate,
      'date': DateTime.now().toString().split(' ')[0],
    });

    typeController.clear();
    weightController.clear();
    rateController.clear();
    fetchScrap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('سکریپ مینجمنٹ')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: typeController,
              decoration: InputDecoration(labelText: 'سکریپ کی قسم'),
            ),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'وزن (کلو)'),
            ),
            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'ریٹ'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addScrap,
              child: Text('سکریپ ایڈ کریں'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: scrapList.length,
                itemBuilder: (context, index) {
                  final item = scrapList[index];
                  return ListTile(
                    title: Text(item['scrap_type']),
                    subtitle: Text(
                        'Weight: ${item['weight']}, Rate: ${item['rate']}, Total: ${item['total']}'),
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
