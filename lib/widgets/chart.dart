import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:personal_expance/widgets/chart_bar.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  Chart({Key? key, required this.resentTransaction}) : super(key: key);

  List<Transaction> resentTransaction;

  List<Map<String, Object>> get groupedTransection {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (int i = 0; i < resentTransaction.length; i++) {
        if (resentTransaction[i].date.day == weekDay.day &&
            resentTransaction[i].date.month == weekDay.month &&
            resentTransaction[i].date.year == weekDay.year) {
          totalSum += resentTransaction[i].amount;
        }
      }
      print(weekDay.format('D'));
      print(totalSum);
      return {"day": weekDay.format('D').substring(0, 2), "amount": totalSum};

      ///it give sortcut for day/ m for monday
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransection.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransection);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransection.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  e['day'] as String,
                  (e['amount'] as double),
                  totalSpending == 0.0
                      ? 0.0
                      : ((e['amount'] as double) / totalSpending)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
