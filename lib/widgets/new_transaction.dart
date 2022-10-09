// import 'dart:html';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addtra; //it store pointer of _addnewtran..

  NewTransaction({required this.addtra});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  //  NewTransaction({Key? key}) : super(key: key);
  final _titleController = TextEditingController();
  final _amountContrialler = TextEditingController();
  DateTime? _selectedDate;

  void _submitdata() {
    // print(titleInput);
    // print(titleController.text);
    // print(amountContrialler.text);
    if (_titleController.text == null || _amountContrialler.text == null) {
      return;
    }
    final enteredTitle = _titleController.text;

    final enteredAmount = double.parse(_amountContrialler.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addtra(enteredTitle, enteredAmount,
        _selectedDate); //widget. ni madad thi bahar na bija class ni pan method use kari sakiye //addtra e NewTransaction ma che
    //_NewTransactionState class ma addtra no use karvo hoy toh widget. use thay
    Navigator.of(context).pop(); //data submit thay etle widet cloes
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickdedDate) {
      if (pickdedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickdedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
            child: Padding(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10//for device keybord title and amount will show
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                // onChanged: (value) => titleInput = value,
                // or we use controler also
                controller: _titleController,
                decoration: InputDecoration(labelText: 'title'),
                onSubmitted: (_) => _submitdata(),
              ),
              TextField(
                controller: _amountContrialler,
                //or
                // onChanged: (value) => amountInput = value,
                decoration: InputDecoration(labelText: 'amount'),
                keyboardType: TextInputType.number,
                // onSubmitted: submitdata, //throw error
                onSubmitted: (_) =>
                    _submitdata(), //_ mean i  dont care about argument just run submitdata fuction//anonims fuction ma submitdata pachi () avej
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? "No Date selected!"
                        : _selectedDate!.format(DateTimeFormats.american),
                  ),
                  TextButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        "Choose Date",
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.w700),
                      ))
                ],
              ),
              ElevatedButton(
                onPressed: _submitdata,
                child: Text("Add transaction"),
              )
            ],
          ),
        )),
      ),
    );
  }
}
