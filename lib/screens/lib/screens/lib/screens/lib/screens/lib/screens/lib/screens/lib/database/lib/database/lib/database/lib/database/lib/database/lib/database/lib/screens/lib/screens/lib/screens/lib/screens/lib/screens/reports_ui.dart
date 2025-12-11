import 'package:flutter/material.dart';
import '../database/reports_helper.dart';

class ReportsUI extends StatefulWidget {
  @override
  _ReportsUIState createState() => _ReportsUIState();
}

class _ReportsUIState extends State<ReportsUI> {
  final reportsHelper = ReportsHelper();

  List<Map<String, dynamic>> dailyReport = [];
  double profit = 0.0;
  String selectedDate = DateTime.now().toString().split(' ')[0];

  @override
  void initState() {
    super.initState();
    fetchDailyReport();
  }

  void fetchDailyReport() async {
    final data = await reportsHelper.getDailyReport(selectedDate);
    final totalProfit = await reportsHelper.getProfit(selectedDate);
    setState(() {
      dailyReport = data;
      profit = totalProfit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('رپورٹس')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Selected Date: $selectedDate'),
            ElevatedButton(
              onPressed: fetchDailyReport,
              child: Text('روزانہ رپورٹ دیکھیں'),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: dailyReport.length,
                itemBuilder: (context, index) {
                  final item = dailyReport[index];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Morning Entries: ${item['morning']}'),
                          Text('Evening Entries: ${item['evening']}'),
                          Text('Scrap Entries: ${item['scrap']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Text('کل منافع: $profit'),
          ],
        ),
      ),
    );
  }
}
