import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personalexpences/models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  TransactionList(this.transactions);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.blueAccent,
      child: ListView(
          children: transactions.map((transaction) {
            return Card(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.teal[800],
                        width: 2.0,
                      )
                    ),
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      // '₱ ' + transaction.amount.toString(),
                      '₱${transaction.amount.toString()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.teal[800]                         
                      ),
                    )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        transaction.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                        ),
                      ),
                      Text(
                        DateFormat.yMMMMEEEEd().format(transaction.date),
                        style: TextStyle(
                          color: Colors.blueGrey[500]
                        ),
                      )
                    ],
                  ),
                ]
              ),
              elevation: 5,
            );
          }).toList(),
        ),
    );
  }


}