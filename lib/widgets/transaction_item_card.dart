import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionItemCard extends StatelessWidget {
  const TransactionItemCard({
    Key? key,
    required this.inx,
    required this.trans,
    required this.deleteTrans,
  }) : super(key: key);

  final List<Transaction> trans;
  final Function deleteTrans;
final int inx;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Card(
        color: Colors.grey[200],
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 3),
                child: FittedBox(
                    child: Text(
                        '\$ ${trans[inx].amount.toString()}')),
              ),
            ),
            title: Text(
              trans[inx].title,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              trans[inx]
                  .date
                  .format(DateTimeFormats.american),
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: MediaQuery.of(context).size.width > 460
                ? FlatButton.icon(
                    color: Colors.white,
                    textColor: Theme.of(context).errorColor,
                    onPressed: () =>
                        deleteTrans(trans[inx].id),
                    icon: Icon(Icons.delete),
                    label: Text("delete"))
                : IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () =>
                        deleteTrans(trans[inx].id),
                  ),
          ),
        ),
      ),
    );
  }
}