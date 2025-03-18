import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myott/UI/PaymentGateways/Controller/PaymentGatewayController.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../Profile/screens/SubscriptionPackage/SubscriptionController.dart';

class PaymentSelectionScreen extends StatefulWidget {
  @override
  _PaymentSelectionScreenState createState() => _PaymentSelectionScreenState();
}

class _PaymentSelectionScreenState extends State<PaymentSelectionScreen> {
  final PaymentGatewayController paymentGatewayController=Get.put(PaymentGatewayController());
  final SubscriptionController controller = Get.put(SubscriptionController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Payment Gateway")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            InkWell(
              onTap: (){
                controller.proceedToPayment();

              },
              child: Container(
                decoration: BoxDecoration(

                ),
                child:  Image.network("https://cdn.iconscout.com/icon/free/png-512/free-razorpay-logo-icon-download-in-svg-png-gif-file-formats--payment-gateway-brand-logos-icons-1399875.png?f=webp&w=512",height: 100,)

              ),
            ),
            InkWell(
              onTap: (){
                paymentGatewayController.startPayPalPayment(context, 100);

              },
              child: Container(
                child:   Image.network("https://cdn.iconscout.com/icon/free/png-512/free-paypal-icon-download-in-svg-png-gif-file-formats--company-brand-logo-social-media-3-pack-logos-icons-10439207.png?f=webp&w=512",height: 100,)

              ),
            ),
          ],
        ),
      ),
    );
  }


}
