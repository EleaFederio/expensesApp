import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    // @required needs 'package:flutter/foundation.dart'
    @required this.id, 
    @required this.title, 
    @required this.amount, 
    @required this.date
  });  
}