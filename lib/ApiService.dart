import 'dart:async';
import 'dart:convert';
import 'dart:io';



import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';


import 'ModelC.dart';
import 'ModelScanner.dart';


class ApiService{
  static Future<ModelScanner> Login(String Code) async{
    var login;



    var request = http.MultipartRequest('POST', Uri.parse('http://172.10.10.128:9595/ScannerKala/api/Scanner/ScannPro'));
    request.fields.addAll({
      'ID': Code.toString()
    });



    print(request.fields.toString());
    http.StreamedResponse response = await request.send().timeout(
      Duration(seconds: 10)) ;

    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      String Main=await response.stream.bytesToString();
      print(Main.toString());
      login=modelScannerFromJson(Main);
    }


    return login;
  }
}