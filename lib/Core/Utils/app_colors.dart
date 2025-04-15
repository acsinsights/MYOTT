import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Home/Controller/themeController.dart';

class AppColors {
  static final ThemeController _themeController = Get.find();

  static bool get isDark => _themeController.isDarkMode.value;

  static Color get background => isDark ? Colors.black : Colors.white;
  static Color get card => isDark ? Color(0xFF1E1E1E) : Color(0xFFF5F5F5);
  static Color get text => isDark ? Colors.white : Colors.black;
  static Color get subText => isDark ? Colors.white70 : Colors.black54;
  static Color get border => isDark ? Colors.white30 : Colors.black26;

  // Constant colors
  static const Color primary = Colors.red;
  static const Color primary2 = Colors.redAccent;
  static const Color darkGrey = Color(0xFF222222);
  static const Color white = Colors.white;
  static const Color subwhite = Colors.white60;
  static const Color transparent = Colors.transparent;
  static const Color green = Colors.green;
  static const Color black = Colors.black;

  static const Color red = Color(0xFFE50914);
  static const Color blue = Color(0xFF2196F3);
  static const Color yellow = Color(0xFFFBC02D);

  static const backgroundWhite = Colors.white;
  static const textBlack = Colors.black;
  static const textGray = Colors.grey;
  static const textFieldBG = Color(0xFFF0F0F0);
  static const cardWhite = Color(0xFFFFFFFF);
  static const iconGray = Color(0xFF9E9E9E);
  static const primaryRed = Color(0xFFE53935);
}
