class VerifyOtpResponse {
  final String message;
  final String? token;
  final String? tokenType;
  final String? expiresAt;

  VerifyOtpResponse({
    required this.message,
    this.token,
    this.tokenType,
    this.expiresAt,  // Change this
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      message: json['message'] ?? 'Something went wrong.',
      token: json['access_token'],
      tokenType: json['token_type'],
      expiresAt: json['expires_at'],  // Correct key
    );
  }
}
