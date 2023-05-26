import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropDownValue = 'None';
  TextEditingController _amountcontroller = TextEditingController();
  TextEditingController _typecontroller = TextEditingController();
  List<String> options = ['None', 'Food', 'House/Rent', 'Clothes', 'Others'];

  void _addExpense() {
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
            onPressed: () {},
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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExpense,
        tooltip: 'New',
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
