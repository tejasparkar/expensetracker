import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addnewTransaction;

  NewTransaction(this.addnewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
 
  final _titleController = TextEditingController();
  final _amountControler = TextEditingController();
  DateTime _selectedDate;
  void _submitData() {
    if(_amountControler.text.isEmpty){
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountControler.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addnewTransaction(enteredTitle, enteredAmount , _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: _amountControler,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
             Container(
                height: 70,
                child: Row(
                  children: [
                   Text(
                        _selectedDate == null
                            ? "No Date Choosen!"
                            : 'Picked Date : ${DateFormat('d/MM/y').format(_selectedDate)}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                   
                    FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: _presentDatePicker,
                        child: Text("Choose Date",
                            style: TextStyle(fontWeight: FontWeight.bold)))
                  ],
                ),
              ),
            
            RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                _submitData();
              },
              child: Text(
                "Add Transaction",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
