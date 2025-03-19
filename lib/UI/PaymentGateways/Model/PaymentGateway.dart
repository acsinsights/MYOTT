

import 'dart:convert';

PaymentGateway paymentGatewayFromJson(String str) => PaymentGateway.fromJson(json.decode(str));

String paymentGatewayToJson(PaymentGateway data) => json.encode(data.toJson());

class PaymentGateway {
  String razorpayKey;
  String razorpaySecret;
  dynamic razorpayEnable;
  String paypalClientId;
  dynamic paypalSecretKey;
  String paypalMode;
  String stripeKey;
  dynamic stripeSecret;
  String paystackKey;
  String paystackSecret;
  String paytmKey;
  dynamic paytmSecret;
  String paytmMerchantId;
  String cashfreeAppId;
  dynamic cashfreeSecretId;
  dynamic cashfreeApiUrl;
  dynamic payhereAppCode;
  String payhereAppSecret;
  String payhereMerchantId;
  String payhereMode;
  String ravePublicKey;
  String raveSecretKey;
  String raveCountry;
  String raveSecretHash;
  String ravePrefix;
  String raveLogo;
  dynamic phonepeMerchantId;
  dynamic phonepeSaltKey;
  dynamic phonepeRedirectUrl;
  dynamic phonepeStatus;
  String imApiKey;
  String imAuthToken;
  String imUrl;

  PaymentGateway({
    required this.razorpayKey,
    required this.razorpaySecret,
    required this.razorpayEnable,
    required this.paypalClientId,
    required this.paypalSecretKey,
    required this.paypalMode,
    required this.stripeKey,
    required this.stripeSecret,
    required this.paystackKey,
    required this.paystackSecret,
    required this.paytmKey,
    required this.paytmSecret,
    required this.paytmMerchantId,
    required this.cashfreeAppId,
    required this.cashfreeSecretId,
    required this.cashfreeApiUrl,
    required this.payhereAppCode,
    required this.payhereAppSecret,
    required this.payhereMerchantId,
    required this.payhereMode,
    required this.ravePublicKey,
    required this.raveSecretKey,
    required this.raveCountry,
    required this.raveSecretHash,
    required this.ravePrefix,
    required this.raveLogo,
    required this.phonepeMerchantId,
    required this.phonepeSaltKey,
    required this.phonepeRedirectUrl,
    required this.phonepeStatus,
    required this.imApiKey,
    required this.imAuthToken,
    required this.imUrl,
  });

  factory PaymentGateway.fromJson(Map<String, dynamic> json) => PaymentGateway(
    razorpayKey: json["razorpay_key"],
    razorpaySecret: json["razorpay_secret"],
    razorpayEnable: json["razorpay_enable"],
    paypalClientId: json["paypal_client_id"],
    paypalSecretKey: json["paypal_secret_key"],
    paypalMode: json["paypal_mode"],
    stripeKey: json["stripe_key"],
    stripeSecret: json["stripe_secret"],
    paystackKey: json["paystack_key"],
    paystackSecret: json["paystack_secret"],
    paytmKey: json["paytm_key"],
    paytmSecret: json["paytm_secret"],
    paytmMerchantId: json["paytm_merchant_id"],
    cashfreeAppId: json["cashfree_app_id"],
    cashfreeSecretId: json["cashfree_secret_id"],
    cashfreeApiUrl: json["cashfree_api_url"],
    payhereAppCode: json["payhere_app_code"],
    payhereAppSecret: json["payhere_app_secret"],
    payhereMerchantId: json["payhere_merchant_id"],
    payhereMode: json["payhere_mode"],
    ravePublicKey: json["rave_public_key"],
    raveSecretKey: json["rave_secret_key"],
    raveCountry: json["rave_country"],
    raveSecretHash: json["rave_secret_hash"],
    ravePrefix: json["rave_prefix"],
    raveLogo: json["rave_logo"],
    phonepeMerchantId: json["phonepe_merchant_id"],
    phonepeSaltKey: json["phonepe_salt_key"],
    phonepeRedirectUrl: json["phonepe_redirect_url"],
    phonepeStatus: json["phonepe_status"],
    imApiKey: json["im_api_key"],
    imAuthToken: json["im_auth_token"],
    imUrl: json["im_url"],
  );

  Map<String, dynamic> toJson() => {
    "razorpay_key": razorpayKey,
    "razorpay_secret": razorpaySecret,
    "razorpay_enable": razorpayEnable,
    "paypal_client_id": paypalClientId,
    "paypal_secret_key": paypalSecretKey,
    "paypal_mode": paypalMode,
    "stripe_key": stripeKey,
    "stripe_secret": stripeSecret,
    "paystack_key": paystackKey,
    "paystack_secret": paystackSecret,
    "paytm_key": paytmKey,
    "paytm_secret": paytmSecret,
    "paytm_merchant_id": paytmMerchantId,
    "cashfree_app_id": cashfreeAppId,
    "cashfree_secret_id": cashfreeSecretId,
    "cashfree_api_url": cashfreeApiUrl,
    "payhere_app_code": payhereAppCode,
    "payhere_app_secret": payhereAppSecret,
    "payhere_merchant_id": payhereMerchantId,
    "payhere_mode": payhereMode,
    "rave_public_key": ravePublicKey,
    "rave_secret_key": raveSecretKey,
    "rave_country": raveCountry,
    "rave_secret_hash": raveSecretHash,
    "rave_prefix": ravePrefix,
    "rave_logo": raveLogo,
    "phonepe_merchant_id": phonepeMerchantId,
    "phonepe_salt_key": phonepeSaltKey,
    "phonepe_redirect_url": phonepeRedirectUrl,
    "phonepe_status": phonepeStatus,
    "im_api_key": imApiKey,
    "im_auth_token": imAuthToken,
    "im_url": imUrl,
  };
}
