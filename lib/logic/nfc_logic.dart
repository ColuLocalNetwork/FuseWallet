/*
import 'dart:convert';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:fusewallet/logic/common.dart';
import 'package:fusewallet/screens/send.dart';
import 'package:fusewallet/globals.dart' as globals;
import 'dart:core';
import 'package:flutter/services.dart';

Future<void> startNFC() async {
  NfcData _nfcData;

  _nfcData = NfcData();
  _nfcData.status = NFCStatus.reading;

  print('NFC: Scan started');

  FlutterNfcReader.read.listen((response) {
    _nfcData = response;
    print('NFC _nfcData: $_nfcData');
    print('NFC _nfcData.content: ${_nfcData.content}');
    String content = _nfcData.content.substring(7);
    print('NFC content: $content');
    Map<String, dynamic> jsonObj = jsonDecode(content);

    openPage(
        globals.scaffoldKey.currentContext,
        new SendPage(
            address: globals.publicKey, privateKey: jsonObj["Private"]));
  });
}

Future<void> stopNFC() async {
  NfcData response;

  try {
    print('NFC: Stop scan by user');
    response = await FlutterNfcReader.stop;
  } on PlatformException {
    print('NFC: Stop scan exception');
    response = NfcData(
      id: '',
      content: '',
      error: 'NFC scan stop exception',
      statusMapper: '',
    );
    response.status = NFCStatus.error;
  }
}

*/