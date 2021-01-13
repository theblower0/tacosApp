// To parse this JSON data, do
//
//     final getResponse = getResponseFromJson(jsonString);

import 'dart:convert';

GetResponse getResponseFromJson(String str) =>
    GetResponse.fromJson(json.decode(str));

String getResponseToJson(GetResponse data) => json.encode(data.toJson());

class GetResponse {
  GetResponse({
    this.res,
    this.message,
  });

  bool res;
  String message;

  factory GetResponse.fromJson(Map<String, dynamic> json) => GetResponse(
        res: json["res"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "res": res,
        "message": message,
      };
}
