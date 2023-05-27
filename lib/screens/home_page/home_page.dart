import 'package:everyday/models/expense_item.dart';
import 'package:everyday/provider/expense_data.dart';
import 'package:everyday/screens/bar_graph/espense_summary.dart';
import 'package:everyday/screens/home_page/components/list_tile.dart';
import 'package:everyday/screens/qr_page/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropDownValue = 'None';
  String dropDownValueIcon = 'assets/images/question.png';
  final TextEditingController _amountcontroller = TextEditingController();
  List<String> options = ['None', 'Food', 'House/Rent', 'Clothes', 'Others'];
  List<String> icon = [
    'assets/images/question.png',
    'assets/images/fast-food.png',
    'assets/images/home.png',
    'assets/images/costume-clothes.png',
    'assets/images/box.png'
  ];

  @override
  void dispose() {
    _amountcontroller.dispose();
    super.dispose();
  }

  void save(String dropDownValue, String dropDownValueIcon) {
    ExpenseItem newExpense = ExpenseItem(
      _amountcontroller.text,
      dropDownValue,
      dropDownValueIcon,
      DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
  }

  void clear() {
    _amountcontroller.clear();
    dropDownValue = 'None';
    dropDownValueIcon = 'assets/images/question.png';
  }

  void addExpense() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
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
              Row(
                children: [
                  const Text(
                    'Category :',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: dropDownValue,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      items: options.map((String comodits) {
                        return DropdownMenuItem(
                          value: comodits,
                          child: Text(
                            comodits,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 18,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue = newValue!;
                          for (int i = 0; i < options.length; i++) {
                            if (options[i] == newValue) {
                              dropDownValueIcon = icon[i];
                            }
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
                clear();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 18),
              ),
            ),
            MaterialButton(
              onPressed: () {
                save(dropDownValue, dropDownValueIcon);
                Navigator.of(context).pop();

                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => QrScan(
                //     amount: _amountcontroller.text.toString(),
                //   ),
                // ));
                clear();
              },
              child: const Text(
                'Scan',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: addExpense,
          tooltip: 'New',
          child: const Icon(Icons.add_outlined),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: ListView(
              children: [
                ExpenseSummary(startOfWeek: value.startOfWeekData()),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.getAll().length,
                  itemBuilder: (context, index) => ExpenseTile(
                    category: value.getAll()[index].category,
                    date: value.getAll()[index].dateAndTime,
                    amount: value.getAll()[index].amount,
                    icon: value.getAll()[index].icon,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
