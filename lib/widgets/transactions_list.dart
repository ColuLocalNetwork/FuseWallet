import 'package:flutter/material.dart';
import 'dart:core';
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
    return transactions != null && transactions.length > 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 15, top: 15, bottom: 8),
                  child: Text("Transactions",
                      style: TextStyle(
                          color: Color(0xFF979797),
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal))),
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
    var color = type == "Received" ? 0xFF71C84D : 0xFFfc6e4c;
    var img = type == "Received" ? "send.png" : "recieve.png";
    return Container(
        decoration: new BoxDecoration(
            border: Border(top: BorderSide(color: const Color(0xFFDCDCDC)))),
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 0),
        child: ListTile(
          title: Text(DateFormat("MMMM d, yyyy").format(_transaction.date)),
          /*subtitle: Text(type,
              style: TextStyle(
                  color: Color(color),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold)),*/
          leading: Opacity(
            opacity: 0.5,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Color(color),
              child: Image.asset('images/' + img,
                  width: 24.0, color: const Color(0xFFFFFFFF)),
            ),
          ),
          trailing: Container(
            child: Text(
              _transaction.amount.toString() + " " + "\$",
              style: TextStyle(
                  color: Color(color),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          ),
        ));
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
            child: Image.asset('images/wallet.png',
                  width: 120.0),
          ),
        ),
        new Text("You have no transactions yet",
            style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/recieve.png', width: 28.0, color: Theme.of(context).primaryColor),
            new Text("Receive coins",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))
          ],
        )
      ],
    );
  }
}
