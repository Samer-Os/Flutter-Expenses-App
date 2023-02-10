import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './bar.dart';
import '../models/transactions.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get allBars {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double amountSum = 0;
      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          amountSum += recentTransaction[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': amountSum,
      };
    }).reversed.toList();
  }

  double get amountSum {
    return allBars.fold(
        0.0, (sum, element) => sum + (element['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: allBars
              .map(
                (tr) => Bar(
                  tr['day'],
                  tr['amount'],
                  amountSum == 0.0 ? 0.0 : (tr['amount'] as double) / amountSum,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
