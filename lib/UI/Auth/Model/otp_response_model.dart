class OtpResponseModel {
  final String message;
  final bool creatingNewAccount;

  OtpResponseModel({required this.message, required this.creatingNewAccount});

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      message: json["message"],
      creatingNewAccount: json["creating_new_account"] ?? false,
    );
  }
}
