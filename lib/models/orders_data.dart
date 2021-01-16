// To parse this JSON data, do
//
//     final ordersData = ordersDataFromJson(jsonString);

import 'dart:convert';

import 'package:tacos_app/models/orders_detail.dart';

List<OrdersData> ordersDataFromJson(String str) =>
    List<OrdersData>.from(json.decode(str).map((x) => OrdersData.fromJson(x)));
String ordersDataToJson(List<OrdersData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// OrdersData ordersDataFromJson(String str) =>
//     OrdersData.fromJson(json.decode(str));

// String ordersDataToJson(OrdersData data) => json.encode(data.toJson());

class OrdersData {
  OrdersData({
    this.id,
    this.emailCliente,
    this.nombreCliente,
    this.createdAt,
    this.updatedAt,
    this.detail,
  });

  int id;
  String emailCliente;
  String nombreCliente;
  DateTime createdAt;
  DateTime updatedAt;
  List<Detail> detail;

  factory OrdersData.fromJson(Map<String, dynamic> json) => OrdersData(
        id: json["id"],
        emailCliente: json["email_cliente"],
        nombreCliente: json["nombre_cliente"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        detail:
            List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email_cliente": emailCliente,
        "nombre_cliente": nombreCliente,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
      };
}
