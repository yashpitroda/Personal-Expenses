// import 'dart:html';
import 'dart:io';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expance/widgets/chart.dart';
// import 'package:intl/intl.dart';

import 'models/transaction.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   //app will no trasform in lasdscap
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final matrialapp = MaterialApp(
      title: 'Personal Expances',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Personal Expances'),
    );
    return matrialapp;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String titleInput = '';
  // String amountInput = '';
  bool _isShowChart = false;
  final List<Transaction> _usertransactionList = [
    // Transaction(
    //   id: "t1",
    //   amount: 89.77,
    //   date: DateTime.now(),
    //   title: "books",
    // ),
    // Transaction(
    //   id: "t2",
    //   amount: 34.67,
    //   date: DateTime.now(),
    //   title: "goods",
    // ),
  ];
  List<Transaction> get _resentTransaction {
    return _usertransactionList.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransection(
      String txtitle, double txamount, DateTime txselectedDate) {
    final newtx = Transaction(
        id: DateTime.now().toString(),
        amount: txamount,
        date: txselectedDate,
        title: txtitle);
    setState(() {
      _usertransactionList.add(newtx);
    });
  }

  void _deleteTrsnsaction(String txid) {
    setState(() {
      _usertransactionList.removeWhere((element) {
        return element.id == txid;
      });
    });
  }

  void _startaddnewtransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(
            addtra: _addNewTransection,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery =
        MediaQuery.of(context); //improve perfomance// it well never change
    // print(
    //     DateTimeFormat.relative(DateTime.now().subtract(Duration(minutes: 5))));
    // print(DateTime.now().subtract(Duration(days: 4)));
    // print(DateTime.now().subtract(Duration(days: 0)).format('D'));
    final _islandscape = (mediaQuery.orientation ==
        Orientation
            .landscape); //() will return bool value //if we are in landcape mode taen it true otherwise it is false
    final _androidAppbar = AppBar(
      title: Text("Personal Expances"),
      actions: [
        IconButton(
          onPressed: () => _startaddnewtransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
    );
    final _iosAppbar = CupertinoNavigationBar(
      middle: Text("Personal Expances"),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        GestureDetector(
            onTap: () => _startaddnewtransaction(context),
            child: Icon(CupertinoIcons.add))
      ]),
    );

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              _androidAppbar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransationList(
        trans: _usertransactionList,
        deleteTrans: _deleteTrsnsaction,
      ),
    );
    List<Widget> _buildlandscapeContent(
        MediaQueryData mediaQuery, AppBar _androidAppbar, Widget txListWidget) {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "show chart",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Switch.adaptive(
              // adaptive mean andriod ma andriod nu switch icon and ios ma ios nu swith icon
              value: _isShowChart,
              onChanged: (val) {
                setState(() {
                  _isShowChart = val;
                });
              },
            ),
          ],
        ),
        _isShowChart
            ? Container(
                height: (mediaQuery.size.height -
                        _androidAppbar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.6,
                child: Chart(resentTransaction: _resentTransaction))
            : txListWidget,
      ];
    }

    List<Widget> _buildPortaitContent(
        MediaQueryData mediaQuery, AppBar _androidAppbar, Widget txListWidget) {
      return [
        Container(
          height: (mediaQuery.size.height -
                  _androidAppbar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(resentTransaction: _resentTransaction),
        ),
        txListWidget,
      ];
    }

    final mainPageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          if (_islandscape)
            ..._buildlandscapeContent(mediaQuery, _androidAppbar, txListWidget),
          if (!_islandscape)
            ..._buildPortaitContent(mediaQuery, _androidAppbar, txListWidget),

          //if (!_islandscape) txListWidget,
          // if (_islandscape)

          // Divider(),
          // _usertransactionList.isEmpty
          //     ? Container(
          //         height: (MediaQuery.of(context).size.height -
          //                 _appbar.preferredSize.height) *
          //             0.6,
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Center(child: Text("no transaction added yet"))
          //   ],
          // ))
          // :
          // Container(
          //     height: (MediaQuery.of(context).size.height -
          //             _appbar.preferredSize.height) *
          //         0.6,
          // child:

          // ),
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: mainPageBody,
            navigationBar: _iosAppbar,
          )
        : Scaffold(
            appBar: _androidAppbar,
            body: mainPageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Platform.isIOS //jo ios che toh container
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startaddnewtransaction(context),
                  ),
          );
  }
}
