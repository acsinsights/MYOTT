class PaymentHistoryModel {
  String status;
  String message;
  List<PaymentHistoryData> data;

  PaymentHistoryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) => PaymentHistoryModel(
    status: json["status"] ?? "",
    message: json["message"] ?? "",
    data: json["data"] != null
        ? List<PaymentHistoryData>.from(json["data"].map((x) => PaymentHistoryData.fromJson(x)))
        : [],
  );
}

class PaymentHistoryData {
  int id;
  String orderId;
  String invoiceNo;
  int userId;
  int packageId;
  int? contentId; // Nullable
  String? contentType; // Nullable
  String packageType;
  String transactionId; // Should be String
  String paymentMethod;
  int price;
  int offerPrice;
  String currencyName;
  String currencyIcon;
  String transactionStatus;
  String packageStatus;
  DateTime startDate;
  DateTime endDate;
  DateTime createdAt;
  DateTime updatedAt;

  PaymentHistoryData({
    required this.id,
    required this.orderId,
    required this.invoiceNo,
    required this.userId,
    required this.packageId,
    this.contentId,
    this.contentType,
    required this.packageType,
    required this.transactionId,
    required this.paymentMethod,
    required this.price,
    required this.offerPrice,
    required this.currencyName,
    required this.currencyIcon,
    required this.transactionStatus,
    required this.packageStatus,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentHistoryData.fromJson(Map<String, dynamic> json) => PaymentHistoryData(
    id: json["id"] ?? 0,
    orderId: json["order_id"] ?? "",
    invoiceNo: json["invoice_no"] ?? "",
    userId: json["user_id"] ?? 0,
    packageId: json["package_id"] ?? 0,
    contentId: json["content_id"], // Nullable
    contentType: json["content_type"], // Nullable
    packageType: json["package_type"] ?? "",
    transactionId: json["transaction_id"] ?? "", // Fixed to String
    paymentMethod: json["payment_method"] ?? "",
    price: json["price"] ?? 0,
    offerPrice: json["offer_price"] ?? 0,
    currencyName: json["currency_name"] ?? "",
    currencyIcon: json["currency_icon"] ?? "",
    transactionStatus: json["transaction_status"] ?? "",
    packageStatus: json["package_status"] ?? "",
    startDate: json["start_date"] != null ? DateTime.parse(json["start_date"]) : DateTime.now(),
    endDate: json["end_date"] != null ? DateTime.parse(json["end_date"]) : DateTime.now(),
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : DateTime.now(),
  );
}
