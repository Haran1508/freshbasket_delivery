import 'package:flutter/material.dart';
import 'package:get/get.dart';

errorSnackBar(String title, String message, [Color colorCode = Colors.red]) {
  return Get.snackbar(
    title,
    message,
    backgroundColor: colorCode,
    colorText: Colors.black,
    snackStyle: SnackStyle.GROUNDED,
    borderRadius: 0,
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.all(0),
    padding: EdgeInsets.all(5),
    shouldIconPulse: true,
    icon: Icon(Icons.error_outline, color: Colors.white),
  );
}


successSnackBar(String title, String message, [Color colorCode = Colors.black54]) {
  return Get.snackbar(
    title,
    message,
    backgroundColor: colorCode,
    colorText: Colors.white,
    snackStyle: SnackStyle.GROUNDED,
    borderRadius: 0,
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.all(0),
    padding: EdgeInsets.all(5),
    shouldIconPulse: true,
  );
}
