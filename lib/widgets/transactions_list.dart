import 'package:flutter/material.dart';
import 'package:fusewallet/crypto.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:fusewallet/modals/transactions.dart';
import 'package:fusewallet/globals.dart' as globals;
import 'package:intl/intl.dart';

//class TransactionsList extends StatefulWidget {
//  TransactionsList({Key key, this.transactions}) : super(key: key);

//  final List<Transaction> transactions;

//  @override
//  _TransactionsListState createState() => _TransactionsListState(transactions);
//}

class TransactionsWidget extends StatefulWidget {
  List<Transaction> transactions;

  TransactionsWidget(this.transactions);

  @override
  createState() => new TransactionsWidgetState(transactions);
}

class TransactionsWidgetState extends State<TransactionsWidget> {
  List<Transaction> transactions;

  TransactionsWidgetState(this.transactions);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext _context) {
    return transactions.length > 0
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(padding:EdgeInsets.only(left: 15, top: 15),
              child: Text("Transactions",style: TextStyle(
                color: Color(0xFF666666),
                fontSize: 14.0,
                fontWeight: FontWeight.bold))
              ),
              ListView(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  children: transactions
                      .map((transaction) => _TransactionListItem(transaction))
                      .toList())
            ],
          )
        : TransactionsEmpty();
  }
}

class _TransactionListItem extends StatelessWidget {
  final Transaction _transaction;

  _TransactionListItem(this._transaction);

  @override
  Widget build(BuildContext context) {
    var type = _transaction.to == globals.publicKey ? "Received" : "Sent";
    var color = type == "Received" ? 0xFF2bb28e : 0xFFbf2b2b;
    return ListTile(
      title: Text(DateFormat("MMMM d, yyyy").format(_transaction.date)),
      subtitle: Text(type,
          style: TextStyle(
              color: Color(color),
              fontSize: 18.0,
              fontWeight: FontWeight.bold)),
      trailing: Container(
          child: Text(
            _transaction.amount.toString() + " " + _transaction.tokenSymbol,
            style: TextStyle(
                color: Color(color),
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
          decoration: new BoxDecoration(
              border: new Border.all(color: Color(color), width: 3.0),
              borderRadius: new BorderRadius.only(
                topLeft: new Radius.circular(30.0),
                topRight: new Radius.circular(30.0),
                bottomRight: new Radius.circular(30.0),
                bottomLeft: new Radius.circular(30.0),
              ))),
    );
  }
}

class TransactionsEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
          child: Opacity(
            opacity: 0.2,
            child: const Icon(Icons.local_gas_station,
                size: 120.0, color: const Color(0xFF393174)),
          ),
        ),
        new Text("You have no transactions yet",
            style: TextStyle(color: const Color(0xFF393174), fontSize: 14)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(
              Icons.arrow_downward,
              color: const Color(0xFF393174),
              size: 28,
            ),
            new Text("Receive coins",
                style: TextStyle(
                    color: const Color(0xFF393174),
                    fontSize: 18,
                    fontWeight: FontWeight.bold))
          ],
        )
      ],
    );
  }
}
