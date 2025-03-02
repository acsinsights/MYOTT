import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myott/UI/Auth/Component/custom_text_field.dart';
import 'package:myott/UI/Components/custom_button.dart';
import 'package:myott/UI/Setting/Wallet/wallet_controller.dart';
import 'package:myott/Utils/app_text_styles.dart';

import 'Components/AlertRows.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WalletController walletController=Get.put(WalletController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.white),
        onPressed: (){
          Get..back();
        },),
        backgroundColor: Colors.black,
        title: Text("Wallet",style: AppTextStyles.Headingb4,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFF3C3939)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Balance",style: AppTextStyles.Headingb4,),
                      Text("0.00",style: AppTextStyles.Heading4,)
                    ],
                  ),
                  Divider(color: Colors.white,),
                  SizedBox(height: 20,),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                      controller: walletController.moneyController,
                      hintText: "0.00"),
                  SizedBox(height: 20,),
                  CustomButton(text: "Add Money to wallet",
                      backgroundColor: Colors.black,
                      borderColor: Colors.red,


                      onPressed: (){

                      }),
                  SizedBox(height: 20,),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AlertRows(
                        icon: Icons.lock,
                        text: "Once the money is added in wallet its non refundable.",
                      ),
                      AlertRows(
                        icon: Icons.star,
                        text: "You can use this money to purchase product on this portal.",
                      ),
                      AlertRows(
                        icon: Icons.info_rounded,
                        text: "Money will expire after 1 year from credited date.",
                      ),
                      AlertRows(
                        icon: Icons.info_rounded,
                        text: "Wallet amount will always added in default currency which is: INR",
                      ),

                    ],
                  )

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}


