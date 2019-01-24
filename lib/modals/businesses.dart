import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
      account: json['account'],
      address: json['address'],
      description: json['description'],
      id: json['id'],
      image: json['image'],
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
  return http.get("https://wbackend-prod.fuse.io/api/entities/0x86a4f4fff3769a8c16d55ceb81594d481c513a3d").then((response) {
  
    List<Business> l = new List();
    final dynamic responseJson = json.decode(response.body);
    responseJson.forEach((f) => l.add(new Business.fromJson(f["data"])));
    return l;
});
}
