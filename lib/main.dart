import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personalexpences/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final List<Transaction> transactions = [
    Transaction(id: 't1', title: 'Power', amount: 20.00, date: DateTime.now()),
    Transaction(id: 't1', title: 'Wind', amount: 10.00, date: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenz')
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              child: Text('Chart'),
              elevation: 5,
            ),
          ),
          Column(
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
          )
        ]
      )
    );
  }
}
