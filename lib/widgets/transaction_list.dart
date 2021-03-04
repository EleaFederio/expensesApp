import 'package:flutter/material.dart';
import 'package:personalexpences/models/transaction.dart';
import 'package:personalexpences/widgets/transaction_item.dart';

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
                return TransactionItem(transaction: transactions[item], deleteTransactiomn: deleteTransactiomn);
              },
              itemCount: transactions.length,
            ),
    );
  }
}


