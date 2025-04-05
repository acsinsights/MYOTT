import 'dart:io';

import 'package:myott/Core/Utils/app_common.dart';
import '../../../services/PaymentGateway/PaymentManager.dart';

class PaymentData {
  final PaymentMethod method;
  final int price;
  final int? offerprice;
  final String? currency;
  final String? transactionID;
  final String? transactionStatus;
  final String? packageStatus;
  final String? packageType;
  final String? paymentType;
  final int? packageid;
  final String? email;
  final String? contact;
  final int? contentId;
  final MediaType? contentType;
  final Map<String, dynamic>? extraData;

  PaymentData({
    required this.method,
    required this.price,
    this.offerprice,
    this.currency,
    this.transactionID,
    this.transactionStatus,
    this.packageStatus,
    this.packageType,
    this.paymentType,
    this.packageid,
    this.email,
    this.contact,
    this.contentId,
    this.contentType,
    this.extraData,
  });

  /// ✅ Returns either the offer price or base price
  int get finalAmount => offerprice != null && offerprice! > 0 ? offerprice! : price;

  /// ✅ Converts object to JSON map based on payment type
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'payment_method': method.name.toLowerCase(),
      'price': price,
      'offer_price': offerprice,
      'currency_name': currency,
      'transaction_id': transactionID,
      'transaction_status': transactionStatus,
      'payment_method': paymentType,
      'contact': contact,
      'email': email,
      'extraData': extraData,
    };

    if (paymentType == 'subscription') {
      data['packageType'] = packageType;
      data['package_id'] = packageid;
      data['package_status'] = packageStatus;
    } else if (paymentType == 'coin' || paymentType == 'ppv') {
      data['content_id'] = contentId;
      data['content_type'] = contentType?.name.toLowerCase();
    }

    return data;
  }

  PaymentData copyWith({
    PaymentMethod? method,
    int? price,
    int? offerprice,
    String? currency,
    String? transactionID,
    String? transactionStatus,
    String? packageStatus,
    String? packageType,
    String? paymentType,
    int? packageid,
    String? email,
    String? contact,
    int? contentId,
    MediaType? contentType,
    Map<String, dynamic>? extraData,
  }) {
    return PaymentData(
      method: method ?? this.method,
      price: price ?? this.price,
      offerprice: offerprice ?? this.offerprice,
      currency: currency ?? this.currency,
      transactionID: transactionID ?? this.transactionID,
      transactionStatus: transactionStatus ?? this.transactionStatus,
      packageStatus: packageStatus ?? this.packageStatus,
      packageType: packageType ?? this.packageType,
      paymentType: paymentType ?? this.paymentType,
      packageid: packageid ?? this.packageid,
      email: email ?? this.email,
      contact: contact ?? this.contact,
      contentId: contentId ?? this.contentId,
      contentType: contentType ?? this.contentType,
      extraData: extraData ?? this.extraData,
    );
  }

}
