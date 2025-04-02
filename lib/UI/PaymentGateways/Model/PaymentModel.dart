import '../../../services/PaymentGateway/PaymentManager.dart';

class PaymentData {
  final PaymentMethod method;
  final int price;
  final int? offerprice;
  final String? currency;
  final String? description;
  final String? email;
  final String? transactionID;
  final String? transactionStatus;
  final String? packageType;
  final String? paymentType;
  final int? packageid;
  final String? contact;
  final Map<String, dynamic>? extraData;

  PaymentData({
    required this.method,
    required this.price,
    this.offerprice,
    this.packageid,
    this.packageType,
    this.transactionID,
    this.paymentType,
    this.transactionStatus,
    this.currency = "USD",
    this.description,
    this.email,
    this.contact,
    this.extraData,
  });

  // ✅ Final amount getter
  int get finalAmount => offerprice != null && offerprice! > 0 ? offerprice! : price;
}
