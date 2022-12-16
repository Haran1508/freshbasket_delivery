import 'package:flutter/material.dart';
import 'package:freshbasket_delivery_partner/config/colors.dart';
import 'package:get/get.dart';

errorSnackBar(String title, String message, [Color colorCode = kPrimaryRed ]) {
  return Get.snackbar(title, message,
      backgroundColor: colorCode,
      colorText: kBackgroudColor,
      snackStyle: SnackStyle.GROUNDED,
      borderRadius: 0,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(5),
      shouldIconPulse: true,
      icon: Icon(Icons.error_outline, color: kBackgroudColor));
}
