import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personalexpences/models/transaction.dart';
import 'package:personalexpences/widgets/chart.dart';
import 'package:personalexpences/widgets/new_transaction.dart';
import 'package:personalexpences/widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
  bool _showChart = false;

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
    // check the mobile device orientation
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // save mediaQuery to one variable
    final mediaQuery = MediaQuery.of(context);

    final curScaleFactor = mediaQuery.textScaleFactor;

    final appBarComponent = AppBar(
      title: Text(
        'Gastoz',
        style: TextStyle(fontSize: 20 * curScaleFactor),
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () => _startAddNewTransaction(context)),
      ],
    );

    final _constructionListWidget = Container(
        height: (mediaQuery.size.height -
                appBarComponent.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));

    print('isLandScape ? ${isLandScape}');

    return Scaffold(
      appBar: appBarComponent,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // check the isLandScape variable and deside if the Switch widget will be shown
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                ],
              ),
            // using if condition to detect eathier it is landsacpe or portrait
            if (!isLandScape)
              Container(
                  height: (mediaQuery.size.height -
                          appBarComponent.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
                  child: Chart(_recentTransactions)),
            if (!isLandScape) _constructionListWidget,

            if (isLandScape)
              // check if _showChart is true or false
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBarComponent.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransactions))
                  : _constructionListWidget,
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
