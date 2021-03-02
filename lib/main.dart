import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personalexpences/models/transaction.dart';
import 'package:personalexpences/widgets/chart.dart';
import 'package:personalexpences/widgets/new_transaction.dart';
import 'package:personalexpences/widgets/transaction_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        secondaryHeaderColor: Colors.amber,
        accentColor: Colors.orange[800],
        backgroundColor: Colors.blue[100],
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w600,
                fontSize: 17),
            button: TextStyle(
              color: Colors.white,
            )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w800)),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(id: 't1', title: 'Cheese Cake', amount: 23.55, date: DateTime.now()),
    // Transaction(id: 't1', title: 'Wind', amount: 10.50, date: DateTime.now()),
    // Transaction(id: 't1', title: 'Adobo', amount: 70.50, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String transactionTitle, double transactionAmount, DateTime choosenDate) {
    final newTransaction = Transaction(
        title: transactionTitle,
        amount: transactionAmount,
        date: choosenDate,
        id: DateTime.now().toString());
    print('transaction title = ' +
        transactionTitle +
        ' ' +
        transactionAmount.toString());
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext modalContext) {
    showModalBottomSheet(
        context: modalContext,
        builder: (_) {
          // GestureDetector prevent from closing when pressed inside the new transaction widget
          return GestureDetector(
            // onTap: () { },
            child: NewTransaction(_addNewTransaction),
            // behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {

    final curScaleFactor = MediaQuery.of(context).textScaleFactor;

    final appBarComponent = AppBar(
      title: Text(
        'Gastoz',
        style: TextStyle(
          fontSize: 20 * curScaleFactor
        ),
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () => _startAddNewTransaction(context)),
      ],
    );

    return Scaffold(
      appBar: appBarComponent,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height - appBarComponent.preferredSize.height - MediaQuery.of(context).padding.top) * 0.3,
              child: Chart(_recentTransactions)
            ),
            Container(
              height: (MediaQuery.of(context).size.height - appBarComponent.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
              child: TransactionList(_userTransactions, _deleteTransaction)
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () => _startAddNewTransaction(context)),
    );
  }
}
