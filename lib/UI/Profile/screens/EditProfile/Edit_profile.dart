import 'package:flutter/material.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Components/custom_button.dart';

import '../../../Components/custom_text_field.dart';
import 'Component/Profilepic.dart';
import 'Component/UserInfoEditField.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(

        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color(0xFF000000),
        foregroundColor: Colors.white,
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            ProfilePic(
              image: 'https://i.postimg.cc/cCsYDjvj/user-2.png',
              imageUploadBtnPress: () {},
            ),
            const Divider(),
            Form(
              child: Column(
                children: [
                  UserInfoEditField(
                    text: "Name",
                    child: CustomTextFieldWithNoBg(
                      initialValue: "Annette Black",
                      hintText: "Enter your name",
                    ),

                  ),
                  UserInfoEditField(
                    text: "Email",
                    child: CustomTextFieldWithNoBg(
                      initialValue: "annette@gmail.com",
                      hintText: "Enter your email",
                    )
                  ),
                  UserInfoEditField(
                    text: "Phone",
                    child: CustomTextFieldWithNoBg(
                      initialValue: "7887317651",
                      hintText: "Enter your Phone No.",
                    ),
                  ),
                  UserInfoEditField(
                    text: "Address",
                    child: CustomTextFieldWithNoBg(
                      initialValue: "Mumbai India",
                      hintText: "Enter Your Address",
                    ),
                  ),
                  UserInfoEditField(
                    text: "Old Password",
                    child: CustomTextFieldWithNoBg(
                      initialValue: "asdasd",
                      obscureText: true,
                      hintText: "Enter Your Old Password",
                    ),
                  ),
                  UserInfoEditField(
                    text: "New Password",
                    child: CustomTextFieldWithNoBg(
                      hintText: "Enter Your new Pass",
                      obscureText: true,
                    )
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 120,
                  child: CustomButton(
                    backgroundColor: Colors.black,
                      borderColor: Colors.white,
                      text: "Cancel",
                      onPressed: (){})
                ),
                const SizedBox(width: 16.0),
                SizedBox(
                  width: 160,
                  child: CustomButton(text: "Save Update", onPressed: (){

                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


