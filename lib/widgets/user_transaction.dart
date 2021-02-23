import 'package:flutter/material.dart';
import 'package:personalexpences/models/transaction.dart';
import 'package:personalexpences/widgets/new_transaction.dart';
import 'package:personalexpences/widgets/transaction_list.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {

  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', title: 'Power', amount: 23.55, date: DateTime.now()),
    Transaction(id: 't1', title: 'Wind', amount: 10.50, date: DateTime.now())
  ];

  void _addNewTransaction(String transactionTitle, double transactionAmount){
    final newTransaction = Transaction(
      title: transactionTitle, 
      amount: transactionAmount,
      date: DateTime.now(),
      id: DateTime.now().toString()
    );
    print('transaction title = ' +transactionTitle + ' ' + transactionAmount.toString());
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Card(
            child: Text('Chart'),
            elevation: 5,
          ),
        ),
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions)
        // ******************************** //
        
      ]
    );
  }
}