import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_common.dart';
import 'package:myott/UI/Profile/Controller/ProfileController.dart';
import '../../services/PaymentGateway/PaymentManager.dart';
import '../Profile/screens/SubscriptionPackage/SubscriptionController.dart';
import 'Model/PaymentData.dart';

class PaymentSelectionScreen extends StatelessWidget {
  final SubscriptionController controller = Get.find<SubscriptionController>(); // ✅ Get.find use karo
  ProfileController profileController=Get.find<ProfileController>();
  final PaymentManager paymentManager = PaymentManager();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {};

    final String paymentType = args['paymentType'] ?? "";
    final int packageid = args['package_id'] ?? 0;
    final String packagestatus = args['packageStatus'] ?? "";
    final int price = args['price'] ?? 0;
    final int offer_price = args['offer_price'] ?? 0;
    final String currency = args['currency'] ?? "";
    final int contentId = args['content_id'] ?? 0;

    final MediaType contentType = args['content_type'] is MediaType
        ? args['content_type']
        : MediaType.movie; // fallback default

    return Scaffold(
      appBar: AppBar(title: Text("Select Payment Gateway")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _paymentOption(
              "https://cdn.iconscout.com/icon/free/png-512/free-razorpay-logo-icon-download-in-svg-png-gif-file-formats--payment-gateway-brand-logos-icons-1399875.png?f=webp&w=512",
              "Razorpay",
                  () {
                   paymentManager.startPayment(PaymentData(
                    method: PaymentMethod.Razorpay,
                    offerprice: offer_price,
                    price: price,
                    paymentType: paymentType,
                    packageid: packageid,
                    packageStatus: packagestatus,
                    currency: currency,
                    email: profileController.user.value!.email,
                    contact:  profileController.user.value!.mobile,
                     contentId: contentId,
                     contentType: contentType
                  ));
                   print(currency);

              }
            ),
            _paymentOption(
              "https://cdn.iconscout.com/icon/free/png-512/free-paypal-icon-download-in-svg-png-gif-file-formats--company-brand-logo-social-media-3-pack-logos-icons-10439207.png?f=webp&w=512",
              "PayPal",
                  () => paymentManager.startPayment(PaymentData(
                    method: PaymentMethod.PayPal,
                    offerprice: offer_price,
                    price: price,
                    paymentType: paymentType,
                    packageid: packageid,
                    packageType: packagestatus,
                    currency: currency,
                    email: profileController.user.value!.email,
                    contact:  profileController.user.value!.mobile,
                  ))
            ),
            _paymentOption(
              "https://cdn.iconscout.com/icon/free/png-512/free-stripe-logo-icon-download-in-svg-png-gif-file-formats--technology-social-media-vol-6-pack-logos-icons-2945188.png?f=webp&w=512",
              "Stripe",
                  () => paymentManager.startPayment(PaymentData(
                    method: PaymentMethod.Stripe,
                    offerprice: offer_price,
                    price: price,
                    packageid: packageid,
                    packageType: packagestatus,
                    currency: currency,
                    paymentType: paymentType,
                    email: profileController.user.value!.email,
                    contact:  profileController.user.value!.mobile,
                  ))
            ),

            _paymentOption(
              "https://cdn.iconscout.com/icon/free/png-512/free-stripe-logo-icon-download-in-svg-png-gif-file-formats--technology-social-media-vol-6-pack-logos-icons-2945188.png?f=webp&w=512",
              "PhonePe",
                  () => paymentManager.startPayment(PaymentData(
                    method: PaymentMethod.PhonePe,
                    offerprice: offer_price,
                    price: price,
                    packageid: packageid,
                    packageType: packagestatus,
                    currency: currency,
                    paymentType: paymentType,
                    email: profileController.user.value!.email,
                    contact:  profileController.user.value!.mobile,
                  ))
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentOption(String imageUrl, String name, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Image.network(imageUrl, height: 100),
      ),
    );
  }
}
