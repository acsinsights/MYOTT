

import 'dart:convert';

SendOtpModel sendOtpModelFromJson(String str) => SendOtpModel.fromJson(json.decode(str));

String sendOtpModelToJson(SendOtpModel data) => json.encode(data.toJson());

class SendOtpModel {
  String message;
  bool creatingNewAccount;

  SendOtpModel({
    required this.message,
    required this.creatingNewAccount,
  });

  factory SendOtpModel.fromJson(Map<String, dynamic> json) => SendOtpModel(
    message: json["message"],
    creatingNewAccount: json["creating_new_account"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "creating_new_account": creatingNewAccount,
  };
}
