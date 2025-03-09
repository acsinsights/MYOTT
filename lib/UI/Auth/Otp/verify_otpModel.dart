class VerifyOtpResponse {
  final String message;
  final String? token;
  final String? tokenType;
  final String? expiresAt;  // Change expiresIn -> expiresAt (String)

  VerifyOtpResponse({
    required this.message,
    this.token,
    this.tokenType,
    this.expiresAt,  // Change this
  });

  /// Convert JSON to Model
  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      message: json['message'] ?? 'Something went wrong.',
      token: json['access_token'],
      tokenType: json['token_type'],
      expiresAt: json['expires_at'],  // Correct key
    );
  }
}
