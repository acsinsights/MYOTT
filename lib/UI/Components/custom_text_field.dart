  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:intl_phone_field/country_picker_dialog.dart';
  import 'package:intl_phone_field/intl_phone_field.dart';

  import '../../Core/Utils/app_colors.dart';
  import '../../Core/Utils/app_text_styles.dart';
  import 'package:intl_phone_field/phone_number.dart';


  class CustomTextField extends StatelessWidget {
    final TextEditingController controller;
    final String hintText;
    final bool isPassword;
    final TextInputType keyboardType;
    final IconData? prefixIcon;
    final IconButton? suffixIcon;
    final VoidCallback? onSuffixTap;
    final ValueChanged<String>? onChanged; // Added onChanged callback

    const CustomTextField({
      super.key,
      required this.controller,
      required this.hintText,
      this.isPassword = false,
      this.keyboardType = TextInputType.text,
      this.prefixIcon,
      this.suffixIcon,
      this.onSuffixTap,
      this.onChanged, // Pass onChanged function
    });

    @override
    Widget build(BuildContext context) {
      return TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: GoogleFonts.poppins(color: AppColors.white),
        onChanged: onChanged, // Assign onChanged callback
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.SubHeading2,
          filled: true,
          fillColor: AppColors.darkGrey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: AppColors.subwhite)
              : null,
          suffixIcon: suffixIcon != null
              ? GestureDetector(
            onTap: onSuffixTap ?? () {},
            child: suffixIcon,
          )
              : null,
        ),
      );
    }
  }


  class CustomTextFieldWithNoBg extends StatelessWidget {
    final TextEditingController? controller;
    final String? initialValue;
    final String? hintText;
    final bool obscureText;
    final IconButton? suffixIcon;
    final TextInputType keyboardType;

    const CustomTextFieldWithNoBg({
      Key? key,
      this.controller,
      this.initialValue,
      this.hintText,
      this.suffixIcon,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return TextFormField(
        controller: controller,
        initialValue: initialValue,
        keyboardType: keyboardType,
        obscureText: obscureText,
        cursorColor: Colors.red,

        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white70),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          border: InputBorder.none,
        ),
      );
    }
  }



  class PhoneNumberField extends StatelessWidget {
    final TextEditingController controller;
    final Function(String) onChanged;

    PhoneNumberField({required this.controller, required this.onChanged});

    @override
    Widget build(BuildContext context) {
      return IntlPhoneField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Enter Phone No.".tr,
          hintStyle: AppTextStyles.SubHeading2,
          filled: true,
          fillColor: AppColors.darkGrey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        initialCountryCode: 'IN', // Default country
        dropdownIcon: Icon(Icons.arrow_drop_down, color: Colors.white),
        style: TextStyle(color: Colors.white),

        dropdownTextStyle: TextStyle(color: Colors.white),
        showDropdownIcon: true,

        onChanged: (PhoneNumber phone) {
          onChanged(phone.completeNumber);
        },

        pickerDialogStyle: PickerDialogStyle(
          backgroundColor: Colors.black,
          searchFieldInputDecoration: InputDecoration(
            hintText: "Search country...",
            hintStyle: TextStyle(color: Colors.white54),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          countryNameStyle: TextStyle(color: Colors.white),
          countryCodeStyle: TextStyle(color: Colors.white),
          searchFieldCursorColor: Colors.white
        ),
      );
    }
  }
