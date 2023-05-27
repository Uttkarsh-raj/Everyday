import 'package:everyday/screens/qr_scanner.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropDownValue = 'None';
  final TextEditingController _amountcontroller = TextEditingController();
  final TextEditingController _typecontroller = TextEditingController();
  List<String> options = ['None', 'Food', 'House/Rent', 'Clothes', 'Others'];

  void save() {}

  void addExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _amountcontroller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Amount',
              ),
            ),
            TextField(
              controller: _typecontroller,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Type',
              ),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 18),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => QrScan(
                  amount: _amountcontroller.text.toString(),
                ),
              ));
            },
            child: const Text(
              'Scan',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: addExpense,
        tooltip: 'New',
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
