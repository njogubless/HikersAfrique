// ignore_for_file: unused_import, prefer_typing_uninitialized_variables, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

// 1. GET Client Credentials
Future getClientCredentials() async {
  String username = FlutterConfig.get('USERNAME');
  String password = FlutterConfig.get('PASSWORD');

  String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  // print('Basic Auth: $basicAuth');

  final response = await http.get(
      Uri.parse('https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials'),
      headers: {'authorization': basicAuth}
  );

  final jsonResponse = jsonDecode(response.body);
  print('JSON Response: $jsonResponse');

  return AccessCredentials.fromJson(jsonResponse);
}

class AccessCredentials{
  final accessToken;
  final expiresIn;

  AccessCredentials({this.accessToken, this.expiresIn});

  factory AccessCredentials.fromJson(Map<String, dynamic> json){
    return AccessCredentials(accessToken: json["MvOfTtRDGLcuLsamtEwkVtwey9uG"], expiresIn: json['3599'],
    );
  }
}

Future processRequest(amount, phoneNumber) async {
  final accessCredentials = await getClientCredentials();

  try{
    final response = await http.post(
        Uri.parse('https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest'),
        headers: {
          'Authorization': 'Bearer ${accessCredentials.accessToken}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "BusinessShortCode": 174379,
          "Password": "MTc0Mzc5YmZiMjc5ZjlhYTliZGJjZjE1OGU5N2RkNzFhNDY3Y2QyZTBjODkzMDU5YjEwZjc4ZTZiNzJhZGExZWQyYzkxOTIwMTYwMjE2MTY1NjI3",
          "Timestamp": "20160216165627",
          "TransactionType": "CustomerPayBillOnline",
          "Amount": "1.00",
          "PartyA": "254708374149",
          "PartyB": "600000",
          "PhoneNumber": "254708374149",
          "CallBackURL": "https://mydomain.com/path",
          "AccountReference": "Test",
          "TransactionDesc": "Test"
        })
    );
    print(jsonDecode(response.body));

  } catch(error){
    print(error);
  }
}