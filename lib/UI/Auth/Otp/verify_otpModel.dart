class VerifyOtpResponse {
  final String message;
  final String? token;
  final String? tokenType;
  final int? expiresIn;

    VerifyOtpResponse({
    required this.message,
    this.token,
    this.tokenType,
    this.expiresIn,
  });

  /// **Convert JSON to Model**
  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      message: json['message'] ?? 'Something went wrong.',
      token: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
    );
  }

  /// **Convert Model to JSON**
  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "access_token": token,
      "token_type": tokenType,
      "expires_in": expiresIn,
    };
  }
}
