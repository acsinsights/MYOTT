import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_common.dart';
import 'package:myott/UI/Profile/Controller/ProfileController.dart';
import '../../services/PaymentGateway/PaymentManager.dart';
import '../Profile/screens/SubscriptionPackage/SubscriptionController.dart';
import 'Model/PaymentData.dart';

class PaymentSelectionScreen extends StatelessWidget {
  final SubscriptionController controller = Get.put(SubscriptionController());
  final ProfileController profileController = Get.find<ProfileController>();
  final PaymentManager paymentManager = PaymentManager();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};

    // Extract values with safe defaults
    final String paymentType = args['paymentType'] ?? "";
    final int packageId = args['package_id'] ?? 0;
    final String packageStatus = args['packageStatus'] ?? "";
    final int price = args['price'] ?? 0;
    final int offerPrice = args['offer_price'] ?? 0;
    final String currency = args['currency'] ?? "INR";
    final int contentId = args['content_id'] ?? 0;

    final String contentTypeString = args['content_type'] ?? 'movie';
    final MediaType contentType = MediaType.values.firstWhere(
          (e) => e.name == contentTypeString,
      orElse: () => MediaType.movie,
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Select Payment Gateway", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTransactionSummary(
              paymentType: paymentType,
              price: price,
              offerPrice: offerPrice,
              currency: currency,
              packageId: packageId,
              packageStatus: packageStatus,
              contentId: contentId,
              contentType: contentType,
            ),
            _buildPaymentCard(
              context,
              "Razorpay",
              "https://cdn.iconscout.com/icon/free/png-512/free-razorpay-logo-icon-download-in-svg-png-gif-file-formats--payment-gateway-brand-logos-icons-1399875.png?f=webp&w=512",
                  () => paymentManager.startPayment(PaymentData(
                method: PaymentMethod.Razorpay,
                offerprice: offerPrice,
                price: price,
                paymentType: paymentType,
                packageid: packageId,
                packageStatus: packageStatus,
                currency: currency,
                contentId: contentId,
                contentType: contentType,
              )),
            ),
            // _buildPaymentCard(
            //   context,
            //   "PayPal",
            //   "https://cdn.iconscout.com/icon/free/png-512/free-paypal-icon-download-in-svg-png-gif-file-formats--company-brand-logo-social-media-3-pack-logos-icons-10439207.png?f=webp&w=512",
            //       () => paymentManager.startPayment(PaymentData(
            //     method: PaymentMethod.PayPal,
            //     offerprice: offerPrice,
            //     price: price,
            //     packageid: packageId,
            //     packageStatus: packageStatus,
            //     currency: currency,
            //     paymentType: paymentType,
            //     email: profileController.user.value?.email,
            //     contact: profileController.user.value?.mobile,
            //   )),
            // ),
            // _buildPaymentCard(
            //   context,
            //   "Stripe",
            //   "https://cdn.iconscout.com/icon/free/png-512/free-stripe-logo-icon-download-in-svg-png-gif-file-formats--technology-social-media-vol-6-pack-logos-icons-2945188.png?f=webp&w=512",
            //       () => paymentManager.startPayment(PaymentData(
            //     method: PaymentMethod.Stripe,
            //     offerprice: offerPrice,
            //     price: price,
            //     packageid: packageId,
            //     packageStatus: packageStatus,
            //     currency: currency,
            //     paymentType: paymentType,
            //     email: profileController.user.value?.email,
            //     contact: profileController.user.value?.mobile,
            //   )),
            // ),
            _buildPaymentCard(
              context,
              "PhonePe",
              "https://cdn.iconscout.com/icon/free/png-512/free-phonepe-logo-icon-download-in-svg-png-gif-file-formats--payment-app-application-indian-companies-pack-logos-icons-2249157.png?f=webp&w=512",
                  () => paymentManager.startPayment(PaymentData(
                method: PaymentMethod.PhonePe,
                    offerprice: offerPrice,
                    price: price,
                    paymentType: paymentType,
                    packageid: packageId,
                    packageStatus: packageStatus,
                    currency: currency,
                    contentId: contentId,
                    contentType: contentType,
                email: profileController.user.value?.email,
                contact: profileController.user.value?.mobile,
              )),
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionSummary({
    required String paymentType,
    required int price,
    required int offerPrice,
    required String currency,
    int? contentId,
    int? packageId,
    String? packageStatus,
    MediaType? contentType,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFF1E1E1E),
      elevation: 10,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("🧾 Transaction Summary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 12),
            _buildSummaryRow("💳 Payment Type:", paymentType.capitalizeFirst ?? "", color: Colors.cyanAccent),
            if (paymentType != "wallet" && packageStatus != null && packageStatus.isNotEmpty)
              _buildSummaryRow("📦 Package Status:", packageStatus.capitalizeFirst ?? ""),
            if (packageId != null && packageId > 0)
              _buildSummaryRow("📦 Package ID:", packageId.toString()),
            // if (contentId != null && contentId > 0)
            //   _buildSummaryRow("🎬 Content ID:", contentId.toString()),
            // if (contentType != null)
            //   _buildSummaryRow("🎞 Content Type:", contentType.name),
            _buildSummaryRow("💰 Price:", "$currency $price"),
            _buildSummaryRow("🔥 Offer Price:", "$currency $offerPrice"),
            SizedBox(height: 6),
            Divider(color: Colors.white24),
            SizedBox(height: 6),
            Text("Choose a payment gateway below 👇", style: TextStyle(fontSize: 14, color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color color = Colors.white}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.white60)),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(
      BuildContext context,
      String name,
      String imageUrl,
      VoidCallback onTap, {
        bool isLast = false,
      }) {
    return Card(
      margin: EdgeInsets.only(bottom: isLast ? 30 : 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Color(0xFF1E1E1E),
      elevation: 8,
      shadowColor: Colors.deepPurpleAccent.withOpacity(0.3),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: Colors.deepPurple.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(imageUrl, height: 50, width: 50, fit: BoxFit.cover),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.white54),
            ],
          ),
        ),
      ),
    );
  }
}
