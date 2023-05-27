import 'package:everyday/provider/expense_data.dart';
import 'package:everyday/screens/bar_graph/components/bar_graph.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: BarGraph(
          maxY: 100,
          sunAmount: 80,
          monAmount: 20,
          tueAmount: 90,
          wedAmount: 30,
          thuAmount: 66,
          friAmount: 55,
          satAmount: 14,
        ),
      ),
    );
  }
}
