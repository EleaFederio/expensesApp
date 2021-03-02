import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personalexpences/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransactiomn;
  TransactionList(this.transactions, this.deleteTransactiomn);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).backgroundColor,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (context, item) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                              '₱${transactions[item].amount.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[item].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(DateFormat.yMMMMEEEEd()
                        .format(transactions[item].date)),
                    // show or hide the button text base on screen size
                    trailing: MediaQuery.of(context).size.width > 350
                        ? FlatButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text('delete'),
                            textColor: Theme.of(context).errorColor,
                            onPressed: () {},
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).accentColor,
                            onPressed: () =>
                                deleteTransactiomn(transactions[item].id),
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
