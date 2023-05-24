// To parse this JSON data, do
//
//     final modelC = modelCFromJson(jsonString);

import 'dart:convert';

ModelC modelCFromJson(String str) => ModelC.fromJson(json.decode(str));

String modelCToJson(ModelC data) => json.encode(data.toJson());

class ModelC {
  List<Re> res;
  bool flag;
  int code;

  ModelC({
    required this.res,
    required this.flag,
    required this.code,
  });

  factory ModelC.fromJson(Map<String, dynamic> json) => ModelC(
    res: List<Re>.from(json["res"].map((x) => Re.fromJson(x))),
    flag: json["flag"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "res": List<dynamic>.from(res.map((x) => x.toJson())),
    "flag": flag,
    "code": code,
  };
}

class Re {
  int id;
  String cityName;
  String provinceName;

  Re({
    required this.id,
    required this.cityName,
    required this.provinceName,
  });

  factory Re.fromJson(Map<String, dynamic> json) => Re(
    id: json["id"],
    cityName: json["cityName"],
    provinceName: json["provinceName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cityName": cityName,
    "provinceName": provinceName,
  };
}
