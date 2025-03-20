import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myott/UI/PaymentGateways/Controller/PaymentGatewayController.dart';


import '../../services/PaymentManager.dart';
import '../Profile/screens/SubscriptionPackage/SubscriptionController.dart';

class PaymentSelectionScreen extends StatefulWidget {
  @override
  _PaymentSelectionScreenState createState() => _PaymentSelectionScreenState();
}

class _PaymentSelectionScreenState extends State<PaymentSelectionScreen> {
  final SubscriptionController controller = Get.put(SubscriptionController());
  PaymentManager paymentManager = PaymentManager();



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
                paymentManager.startPayment(PaymentMethod.Razorpay, 15.00);

              },
              child: Container(
                decoration: BoxDecoration(

                ),
                child:  Image.network("https://cdn.iconscout.com/icon/free/png-512/free-razorpay-logo-icon-download-in-svg-png-gif-file-formats--payment-gateway-brand-logos-icons-1399875.png?f=webp&w=512",height: 100,)

              ),
            ),
            InkWell(
              onTap: (){
                paymentManager.startPayment(PaymentMethod.PayPal, 20.50);

              },
              child: Container(
                child:   Image.network("https://cdn.iconscout.com/icon/free/png-512/free-paypal-icon-download-in-svg-png-gif-file-formats--company-brand-logo-social-media-3-pack-logos-icons-10439207.png?f=webp&w=512",height: 100,)

              ),
            ),
            InkWell(
              onTap: ()async{
                paymentManager.startPayment(PaymentMethod.Stripe, 10.99);

              },
              child: Container(
                  child:   Image.network("https://cdn.iconscout.com/icon/free/png-512/free-stripe-logo-icon-download-in-svg-png-gif-file-formats--technology-social-media-vol-6-pack-logos-icons-2945188.png?f=webp&w=512",height: 100,)

              ),
            ),

          ],
        ),
      ),
    );
  }


}
