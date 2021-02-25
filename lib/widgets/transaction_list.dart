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
      width: double.infinity,
      color: Theme.of(context).backgroundColor,
      child: transactions.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Empty',
                  style: TextStyle(),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (context, item) {
                return Card(
                  child: Row(children: <Widget>[
                    Container(
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Theme.of(context).primaryColorDark,
                          width: 2.0,
                        )),
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          // '₱ ' + transaction.amount.toString(),
                          // show two decimal places
                          '₱${transactions[item].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Theme.of(context).primaryColorDark),
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          transactions[item].title,
                          style: Theme.of(context).textTheme.title,
                        ),
                        Text(
                          DateFormat.yMMMMEEEEd()
                              .format(transactions[item].date),
                          style: TextStyle(color: Theme.of(context).hintColor),
                        )
                      ],
                    ),
                  ]),
                  elevation: 5,
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
