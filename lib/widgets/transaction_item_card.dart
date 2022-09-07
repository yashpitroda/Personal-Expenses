import 'dart:math';

import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionItemCard extends StatefulWidget {
  const TransactionItemCard({
    Key? key,
    required this.inx,
    required this.trans,
    required this.deleteTrans,
  })
   : super(key: key)
   ;

  final List<Transaction> trans;
  final Function deleteTrans;
  final int inx;

  @override
  State<TransactionItemCard> createState() => _TransactionItemCardState();
}

class _TransactionItemCardState extends State<TransactionItemCard> {
  Color? _bgclolor;
  List<Color> _avalibleColor = [
    Colors.red,
    Colors.green,
    Colors.pink,
    Colors.purple,
  ];
  @override
  void initState() {
    _bgclolor = _avalibleColor[Random().nextInt(4)]; //it retrun 0 to 3
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.key);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Card(
        color: Colors.grey[200],
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: CircleAvatar(backgroundColor: _bgclolor,
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: FittedBox(
                    child: Text(
                        '\$ ${widget.trans[widget.inx].amount.toString()}')),
              ),
            ),
            title: Text(
              widget.trans[widget.inx].title,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              widget.trans[widget.inx].date.format(DateTimeFormats.american),
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: MediaQuery.of(context).size.width > 460
                ? FlatButton.icon(
                    color: Colors.white,
                    textColor: Theme.of(context).errorColor,
                    onPressed: () =>
                        widget.deleteTrans(widget.trans[widget.inx].id),
                    icon: Icon(Icons.delete),
                    label: Text("delete"))
                : IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () =>
                        widget.deleteTrans(widget.trans[widget.inx].id),
                  ),
          ),
        ),
      ),
    );
  }
}
