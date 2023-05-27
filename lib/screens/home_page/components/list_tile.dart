import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile(
      {super.key,
      required this.category,
      required this.date,
      required this.amount,
      required this.icon});
  final String category;
  final DateTime date;
  final String amount;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        icon,
        scale: 13,
      ),
      title: Text(category),
      subtitle: Text('${date.day}/${date.month}/${date.year}'),
      trailing: Text('\₹' + amount),
    );
  }
}
