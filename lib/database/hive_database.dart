import 'package:hive/hive.dart';

import '../models/expense_item.dart';

class HiveDatabase {
  final myDatabase = Hive.box("expense_database");

  void saveData(List<ExpenseItem> allExpensen) {
    List<List<dynamic>> allExpensesFormatted = [];
    for (var expense in allExpensen) {
      List<dynamic> formattedExpense = [
        expense.category,
        expense.amount,
        expense.dateAndTime,
        expense.icon,
      ];
      allExpensesFormatted.add(formattedExpense);
    }

    myDatabase.put("ALL_EXPENSES", allExpensesFormatted);
  }

  List<ExpenseItem> readData() {
    List savedExpense = myDatabase.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpense = [];
    for (int i = 0; i < savedExpense.length; i++) {
      String category = savedExpense[i][0];
      String amount = savedExpense[i][1];
      DateTime dateAndTime = savedExpense[i][2];
      String icon = savedExpense[i][3];

      ExpenseItem expense = ExpenseItem(amount, category, icon, dateAndTime);

      allExpense.add(expense);
    }
    return allExpense;
  }
}
