import 'package:everyday/provider/expense_data.dart';
import 'package:everyday/screens/bar_graph/components/bar_graph.dart';
import 'package:everyday/utils/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    String sunday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));
    return Consumer<ExpenseData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: BarGraph(
          maxY: 100,
          sunAmount: value.calculateDailyExpSumm()[sunday] ?? 0,
          monAmount: value.calculateDailyExpSumm()[monday] ?? 0,
          tueAmount: value.calculateDailyExpSumm()[tuesday] ?? 0,
          wedAmount: value.calculateDailyExpSumm()[wednesday] ?? 0,
          thuAmount: value.calculateDailyExpSumm()[thursday] ?? 0,
          friAmount: value.calculateDailyExpSumm()[friday] ?? 0,
          satAmount: value.calculateDailyExpSumm()[saturday] ?? 0,
        ),
      ),
    );
  }
}
