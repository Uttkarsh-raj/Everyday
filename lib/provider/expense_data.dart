import 'package:everyday/database/hive_database.dart';
import 'package:everyday/models/expense_item.dart';
import 'package:everyday/utils/date_time_helper.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  List<ExpenseItem> overallExpense = [];

  List<ExpenseItem> getAll() {
    return overallExpense;
  }

  final db = HiveDatabase();

  void prepareData() {
    if (db.readData().isNotEmpty) {
      overallExpense = db.readData();
    }
  }

  void addNewExpense(ExpenseItem newExpense) {
    overallExpense.add(newExpense);
    notifyListeners();
    db.saveData(overallExpense);
  }

  void deleteExpense(ExpenseItem expense) {
    overallExpense.remove(expense);
    notifyListeners();
    db.saveData(overallExpense);
  }

  String getDayByName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  DateTime startOfWeekData() {
    DateTime? startOfWeek;
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      if (getDayByName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  Map<String, double> calculateDailyExpSumm() {
    Map<String, double> dailyExpSumm = {};
    for (var expense in overallExpense) {
      String date = convertDateTimeToString(expense.dateAndTime);
      double ammount = double.parse(expense.amount);
      if (dailyExpSumm.containsKey(date)) {
        double currentAmount = dailyExpSumm[date]!;
        currentAmount += ammount;
        dailyExpSumm[date] = currentAmount;
      } else {
        dailyExpSumm.addAll({date: ammount});
      }
    }
    return dailyExpSumm;
  }
}
