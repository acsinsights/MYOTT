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

    final String paymentType = args['paymentType'] ?? "";
    final int packageid = args['package_id'] ?? 0;
    final String packagestatus = args['packageStatus'] ?? "";
    final int price = args['price'] ?? 0;
    final int offer_price = args['offer_price'] ?? 0;
    final String currency = args['currency'] ?? "";
    final int contentId = args['content_id'] ?? 0;

    final MediaType contentType = args['content_type'] is MediaType
        ? args['content_type']
        : MediaType.movie;

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
            _buildPaymentCard(
              context,
              "Razorpay",
              "https://cdn.iconscout.com/icon/free/png-512/free-razorpay-logo-icon-download-in-svg-png-gif-file-formats--payment-gateway-brand-logos-icons-1399875.png?f=webp&w=512",
                  () => paymentManager.startPayment(PaymentData(
                method: PaymentMethod.Razorpay,
                offerprice: offer_price,
                price: price,
                paymentType: paymentType,
                packageid: packageid,
                packageStatus: packagestatus,
                currency: currency,
                contentId: contentId,
                contentType: contentType,
              )),
            ),
            _buildPaymentCard(
              context,
              "PayPal",
              "https://cdn.iconscout.com/icon/free/png-512/free-paypal-icon-download-in-svg-png-gif-file-formats--company-brand-logo-social-media-3-pack-logos-icons-10439207.png?f=webp&w=512",
                  () => paymentManager.startPayment(PaymentData(
                method: PaymentMethod.PayPal,
                offerprice: offer_price,
                price: price,
                paymentType: paymentType,
                packageid: packageid,
                packageType: packagestatus,
                currency: currency,
                email: profileController.user.value?.email,
                contact: profileController.user.value?.mobile,
              )),
            ),
            _buildPaymentCard(
              context,
              "Stripe",
              "https://cdn.iconscout.com/icon/free/png-512/free-stripe-logo-icon-download-in-svg-png-gif-file-formats--technology-social-media-vol-6-pack-logos-icons-2945188.png?f=webp&w=512",
                  () => paymentManager.startPayment(PaymentData(
                method: PaymentMethod.Stripe,
                offerprice: offer_price,
                price: price,
                packageid: packageid,
                packageType: packagestatus,
                currency: currency,
                paymentType: paymentType,
                email: profileController.user.value?.email,
                contact: profileController.user.value?.mobile,
              )),
            ),
            // 🟣 PhonePe (last & styled differently)
            _buildPaymentCard(
              context,
              "PhonePe",
              "https://cdn.iconscout.com/icon/free/png-512/free-phonepe-logo-icon-download-in-svg-png-gif-file-formats--payment-app-application-indian-companies-pack-logos-icons-2249157.png?f=webp&w=512", // Better resolution logo
                  () => paymentManager.startPayment(PaymentData(
                method: PaymentMethod.PhonePe,
                offerprice: offer_price,
                price: price,
                packageid: packageid,
                packageType: packagestatus,
                currency: currency,
                paymentType: paymentType,
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

  Widget _buildPaymentCard(BuildContext context, String name, String imageUrl, VoidCallback onTap, {bool isLast = false}) {
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
