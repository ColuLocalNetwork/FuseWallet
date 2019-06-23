import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fusewallet/logic/crypto.dart';

class Business {
  final String account;
  final String address;
  final String description;
  final String id;
  final String image;
  final String name;

  Business({this.account, this.address, this.description, this.id, this.image, this.name});

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      account: json['name'], //json['account'],
      address: json['name'], //json['address'],
      description: json['name'], //json['description'],
      id: json['name'], //json['id'],
      image: json['name'], //json['image'],
      name: json['name']
    );
  }
}

class BusinessList {
  final List<Business> businesses;

  BusinessList({this.businesses});

  factory BusinessList.fromJson(Map<String, dynamic> json) {

    var list = json as List;

    List<Business> businesses = new List<Business>();
    businesses = list.map((i)=>Business.fromJson(i["data"])).toList();

    return new BusinessList(
      businesses: businesses
    );
  }
}

Future<List<Business>> getBusinesses() async {
  var communityAddress = await getCommunityAddress();
  // var listAddress = await getListAddress();
  return http.get("https://ropsten-qa.cln.network/api/v1/entities/" + communityAddress + "?type=business&withMetadata=true").then((response) {
  
    List<Business> l = new List();
    final dynamic responseJson = json.decode(response.body);
    print(responseJson);
    responseJson["data"].forEach((f) => l.add(new Business.fromJson(f)));
    return l;
});
}
