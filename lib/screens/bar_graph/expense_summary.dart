import 'package:everyday/provider/expense_data.dart';
import 'package:everyday/screens/bar_graph/components/bar_graph.dart';
import 'package:everyday/utils/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  String calculateWeekTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    List<double> values = [
      value.calculateDailyExpSumm()[sunday] ?? 0,
      value.calculateDailyExpSumm()[monday] ?? 0,
      value.calculateDailyExpSumm()[tuesday] ?? 0,
      value.calculateDailyExpSumm()[wednesday] ?? 0,
      value.calculateDailyExpSumm()[thursday] ?? 0,
      value.calculateDailyExpSumm()[friday] ?? 0,
      value.calculateDailyExpSumm()[saturday] ?? 0,
    ];
    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

  double calculateMax(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    double? max = 100;
    List<double> values = [
      value.calculateDailyExpSumm()[sunday] ?? 0,
      value.calculateDailyExpSumm()[monday] ?? 0,
      value.calculateDailyExpSumm()[tuesday] ?? 0,
      value.calculateDailyExpSumm()[wednesday] ?? 0,
      value.calculateDailyExpSumm()[thursday] ?? 0,
      value.calculateDailyExpSumm()[friday] ?? 0,
      value.calculateDailyExpSumm()[saturday] ?? 0,
    ];
    values.sort();
    max = values[values.length - 1] * 1.2;
    return max == 0 ? 100 : max;
  }

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
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Weeks Total : ',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '\₹' +
                    calculateWeekTotal(
                      value,
                      sunday,
                      monday,
                      tuesday,
                      wednesday,
                      thursday,
                      friday,
                      saturday,
                    ),
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: BarGraph(
              maxY: calculateMax(value, sunday, monday, tuesday, wednesday,
                  thursday, friday, saturday),
              sunAmount: value.calculateDailyExpSumm()[sunday] ?? 0,
              monAmount: value.calculateDailyExpSumm()[monday] ?? 0,
              tueAmount: value.calculateDailyExpSumm()[tuesday] ?? 0,
              wedAmount: value.calculateDailyExpSumm()[wednesday] ?? 0,
              thuAmount: value.calculateDailyExpSumm()[thursday] ?? 0,
              friAmount: value.calculateDailyExpSumm()[friday] ?? 0,
              satAmount: value.calculateDailyExpSumm()[saturday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
