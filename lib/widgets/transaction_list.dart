import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personalexpences/models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  TransactionList(this.transactions);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Colors.blueAccent,
      child: ListView.builder(
        itemBuilder: (context, item) {
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
                    // show two decimal places
                    '₱${transactions[item].amount.toStringAsFixed(2)}',
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
                      transactions[item].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMEEEEd().format(transactions[item].date),
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
        },
        itemCount: transactions.length,
      ),
    );
  }


}