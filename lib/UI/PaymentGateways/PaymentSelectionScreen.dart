import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Profile/Controller/ProfileController.dart';
import '../../services/PaymentManager.dart';
import '../Profile/screens/SubscriptionPackage/SubscriptionController.dart';
import 'Model/PaymentModel.dart';

class PaymentSelectionScreen extends StatelessWidget {
  final SubscriptionController controller = Get.find<SubscriptionController>(); // ✅ Get.find use karo
  ProfileController profileController=Get.find<ProfileController>();
  final PaymentManager paymentManager = PaymentManager();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {};
    final String paymentType = args['paymentType'] ?? 0.0;
    final int packageid = args['package_id'] ?? "";
    final String packagestatus = args['paymentStatus'] ?? "";
    final int price = args['price'] ?? "";
    final int offer_price = args['offer_price'] ?? "";
    final String currency = args['currency'] ?? "";

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
                    packageType: packagestatus,
                    currency: currency,
                    email: profileController.user.value!.email,
                    contact:  profileController.user.value!.mobile,
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
                    currency: currency,                    paymentType: paymentType,

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
