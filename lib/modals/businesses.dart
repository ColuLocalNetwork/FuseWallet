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
      account: json['account'], //json['account'],
      address: json['metadata'] != null ? json['metadata']['address'] : "", //json['address'],
      description: json['metadata'] != null ? json['metadata']['description'] : "", //json['description'],
      id: json['_id'], //json['id'],
      image: json['image'] ?? 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png', //json['image'],
      name: json['name'] ?? ""
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

Future<List<Business>> getBusinesses(String communityAddress) async {
  // var communityAddress = await getCommunityAddress();
  print('Fetching businesses for commnuity: $communityAddress');
  final response = await http.get(API_ROOT + "entities/" + communityAddress + "?type=business&withMetadata=true");

   if (response.statusCode == 200) {
    List<Business> businessList = new List();
    final dynamic responseJson = json.decode(response.body);
    responseJson["data"].forEach((f) => businessList.add(new Business.fromJson(f)));
    print('Done Fetching businesses for commnuity: $communityAddress. length: ${businessList.length}');
    return businessList;
  } else {
    throw Exception('Failed to load business');
  }

  // return http.get(API_ROOT + "entities/" + communityAddress + "?type=business&withMetadata=true").then((response) {
  //   List<Business> businessList = new List();
  //   final dynamic responseJson = json.decode(response.body);
  //   responseJson["data"].forEach((f) => businessList.add(new Business.fromJson(f)));
  //   print('Done Fetching businesses for commnuity: $communityAddress. length: ${businessList.length}');
  //   return businessList;
  // });
}
