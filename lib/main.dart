import 'package:expensetracker/widgets/chart.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "ExpenseTracker App",
        theme: ThemeData(
            primaryColor: Color(0xff330867),
            accentColor: Color(0xff667eea),
            fontFamily: 'OpenSans'),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: "01", title: "Buy Shoes", amount: 100.22, date: DateTime.now()),
    Transaction(
        id: "03", title: "Buy Milk", amount: 48.99, date: DateTime.now()),
    Transaction(
        id: "04", title: "Buy Veggies", amount: 30.14, date: DateTime.now()),
    Transaction(
        id: "02",
        title: "Weekly Groceries",
        amount: 20.42,
        date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransactions(
      String txTitle, double txAmount, DateTime choosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: choosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _showModaltoAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_addNewTransactions));
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Color(0xffdfe9f3),
      appBar: AppBar(
        leading: Icon(
          Icons.money_sharp,
          color: Colors.black,
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _showModaltoAddTransaction(context))
        ],
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "ExpenseTracker",
        ),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Chart(_recentTransactions),
              TransactionList(_userTransactions, _deleteTransaction)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () => _showModaltoAddTransaction(context)),
    );
  }
}
