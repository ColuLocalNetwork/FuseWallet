import 'package:flutter/material.dart';
import 'package:fusewallet/crypto.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:fusewallet/common.dart';
import 'package:fusewallet/screens/shop.dart';
import 'package:fusewallet/globals.dart' as globals;
import 'package:fusewallet/modals/businesses.dart';

class BuyPage extends StatefulWidget {
  BuyPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BuyPageState createState() => _BuyPageState();
}

List<Business> businessesList = [];

class _BuyPageState extends State<BuyPage> {
  GlobalKey<ScaffoldState> scaffoldState;
  bool isLoading = false;
  final addressController = TextEditingController(text: "");
  final amountController = TextEditingController(text: "");

  void loadBusinesses() {
    getBusinesses().then((list) {
      setState(() {
        businessesList.clear();
        businessesList.addAll(list);
      });
    });
  }

  @override
  void initState() {
    super.initState();

    loadBusinesses();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldState,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
        ),
        body: ListView(children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(20.0),
            child: Text("Buy",
                style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontSize: 38,
                    fontWeight: FontWeight.bold)),
          ),
          new BusinessesListView()
        ]));
  }
}

class BusinessesListView extends StatefulWidget {
  @override
  createState() => new BusinessesListViewState();
}

class BusinessesListViewState extends State<BusinessesListView> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(8.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        textDirection: TextDirection.rtl,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Expanded(
                child: new Padding(
                    padding: new EdgeInsets.only(bottom: 5.0),
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          new Divider(),
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: businessesList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: ClipOval(
                              child: Image.network(
                            businessesList[index].image,
                            fit: BoxFit.cover,
                            width: 50.0,
                            height: 50.0,
                          )),
                          title: Text(businessesList[index].name),
                          subtitle: Text(businessesList[index].address),
                          onTap: () {
                            openPage(globals.scaffoldKey.currentContext,
                                new ShopPage(business: businessesList[index],));
                          },
                        );
                      },
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
