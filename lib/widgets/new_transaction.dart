import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {

  final Function addTransaction;

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      // wrap column with container to create spacing inside the column
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title'
              ),
              controller: titleController,
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount'
              ),
              controller: amountController,
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              textColor: Colors.teal[800],
              onPressed: () {
                // print(titleInput);
                addTransaction(titleController.text, double.parse(amountController.text));
              }
            )
          ]
        ),
      ),
    );
  }
}