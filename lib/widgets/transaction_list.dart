import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
import 'package:date_time_format/date_time_format.dart';
import '../models/transaction.dart';

class TransationList extends StatelessWidget {
  List<Transaction> trans = [];
  final Function deleteTrans;
  TransationList({required this.trans, required this.deleteTrans});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Card(
        color: Colors.white,
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: trans.isEmpty
              ? LayoutBuilder(builder: (context, contraints) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: cros,
                    children: [
                      Center(child: const Text("no transaction added yet")),//this will never change dynamicaly so we use const 
                      Container(
                          height: contraints.maxHeight * 0.6,
                          child: Image.asset("assets/minions_PNG8.png"))
                    ],
                  );
                })
              : ListView.builder(
                  itemCount: trans.length,
                  itemBuilder: (context, index) {
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
                                        '\$ ${trans[index].amount.toString()}')),
                              ),
                            ),
                            title: Text(
                              trans[index].title,
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            subtitle: Text(
                              trans[index]
                                  .date
                                  .format(DateTimeFormats.american),
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            trailing: MediaQuery.of(context).size.width > 460
                                ? FlatButton.icon(
                                    color: Colors.white,
                                    textColor: Theme.of(context).errorColor,
                                    onPressed: () =>
                                        deleteTrans(trans[index].id),
                                    icon: Icon(Icons.delete),
                                    label: Text("delete"))
                                : IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Theme.of(context).errorColor,
                                    ),
                                    onPressed: () =>
                                        deleteTrans(trans[index].id),
                                  ),
                          ),
                        ),
                      ),
                    );
                    //or
                    // Card(
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         margin:
                    //             EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    //         padding: EdgeInsets.all(6),
                    //         decoration: BoxDecoration(
                    //             border: Border.all(
                    //           width: 2,
                    //           color: Theme.of(context).primaryColorLight,
                    //         )),
                    //         child: Text(
                    //           // tx.amount.toString(),
                    //           // '\$ ${trans[index].amount}',
                    //           '\$ ${trans[index].amount.toStringAsFixed(2)}',
                    //           style: TextStyle(
                    //               color: Theme.of(context).primaryColorDark,
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 20),
                    //         ),
                    //       ),
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             trans[index].title,
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.bold, fontSize: 16),
                    //           ),
                    //           SizedBox(
                    //             height: 4,
                    //           ),
                    //           Text( trans[index].date.format(DateTimeFormats.american),
                    //             // DateFormat.yMMMMEEEEd().format(trans[index].date),
                    //           //  DataFormat.format(trans[index].date.toString()),
                    //             // DateFormat('yyyy-MM-dd').format(tx.date),
                    //             // DateFormat('yyyy/MM/dd').format(tx.date),
                    //             style: TextStyle(color: Colors.grey, fontSize: 14),
                    //           ),
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // );
                  }),
        ),
      ),
    );
    //or
    /*
     return Column(
      children: trans.map((tx) {
        return Card(
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 2,
                  color: Colors.purple,
                )),
                child: Text(
                  // tx.amount.toString(),
                  '\$ ${tx.amount}',
                  style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    DateFormat.yMMMMEEEEd().format(tx.date),
                    // DateFormat().format(tx.date),
                    // DateFormat('yyyy-MM-dd').format(tx.date),
                    // DateFormat('yyyy/MM/dd').format(tx.date),
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
    */
  }
}
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     "Transactions",
                //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                //     // color: Theme.of(context).primaryColor,
                //   ),
                // ),