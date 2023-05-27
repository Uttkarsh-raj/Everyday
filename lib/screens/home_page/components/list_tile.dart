import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExpenseTile extends StatelessWidget {
  ExpenseTile(
      {super.key,
      required this.category,
      required this.date,
      required this.amount,
      required this.icon});
  final String category;
  final DateTime date;
  final String amount;
  final String icon;
  var style = TextStyle(
    color: Colors.deepPurple[300],
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        icon,
        scale: 13,
      ),
      title: Text(
        category,
        style: style.copyWith(fontSize: 15),
      ),
      subtitle: Text(
        '${date.day}/${date.month}/${date.year}',
        style: style.copyWith(fontSize: 13),
      ),
      trailing: Text(
        '\₹' + amount,
        style: style.copyWith(color: Colors.deepPurple[400]),
      ),
    );
  }
}
