// To parse this JSON data, do
//
//     final packageModel = packageModelFromJson(jsonString);




class PackageModel {
  int id;
  String planId;
  String name;
  String planUnit;
  int amount;
  String currency;
  int offerPrice;
  List<String> features;
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
    id: json["id"]??0,
    planId: json["plan_id"]??0,
    name: json["name"]??"",
    planUnit: json["plan_unit"]??"",
    amount: json["amount"]??0,
    currency: json["currency"]??"",
    offerPrice: json["offer_price"]??0,
    features: json["features"]!=null ?List<String>.from(json["features"].map((x) => x)):[],
    status: json["status"]??"",
    createdAt: json["created_at"]!=null? DateTime.parse(json["created_at"]):DateTime.now(),
    updatedAt: json["updated_at"]!=null? DateTime.parse(json["updated_at"]):DateTime.now());


}
