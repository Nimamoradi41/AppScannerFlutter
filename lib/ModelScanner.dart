// To parse this JSON data, do
//
//     final modelScanner = modelScannerFromJson(jsonString);

import 'dart:convert';

ModelScanner modelScannerFromJson(String str) => ModelScanner.fromJson(json.decode(str));

String modelScannerToJson(ModelScanner data) => json.encode(data.toJson());

class ModelScanner {
  String msg;
  bool success;
  String priceKala;
  String naka;
  String shka;

  ModelScanner({
    required this.msg,
    required this.success,
    required this.priceKala,
    required this.naka,
    required this.shka,
  });

  factory ModelScanner.fromJson(Map<String, dynamic> json) => ModelScanner(
    msg: json["msg"],
    success: json["success"],
    priceKala: json["priceKala"],
    naka: json["naka"],
    shka: json["shka"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "success": success,
    "Naka": naka,
    "shka": shka,
    "priceKala": priceKala,
    "shka": shka,
  };
}
