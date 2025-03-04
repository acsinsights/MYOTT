// To parse this JSON data, do
//
//     final packageModel = packageModelFromJson(jsonString);

import 'dart:convert';

List<PackageModel> packageModelFromJson(String str) => List<PackageModel>.from(json.decode(str).map((x) => PackageModel.fromJson(x)));

String packageModelToJson(List<PackageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PackageModel {
  int id;
  String planId;
  String name;
  String planUnit;
  int amount;
  String currency;
  int offerPrice;
  String features;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  PackageModel({
    required this.id,
    required this.planId,
    required this.name,
    required this.planUnit,
    required this.amount,
    required this.currency,
    required this.offerPrice,
    required this.features,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
    id: json["id"],
    planId: json["plan_id"],
    name: json["name"],
    planUnit: json["plan_unit"],
    amount: json["amount"],
    currency: json["currency"],
    offerPrice: json["offer_price"],
    features: json["features"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "plan_id": planId,
    "name": name,
    "plan_unit": planUnit,
    "amount": amount,
    "currency": currency,
    "offer_price": offerPrice,
    "features": features,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
