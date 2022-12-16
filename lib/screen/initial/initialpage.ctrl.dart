import 'dart:async';
import 'package:freshbasket_delivery_partner/config/routes.dart';
import 'package:freshbasket_delivery_partner/screen/login/auth.ctrl.dart';
import 'package:get/get.dart';

class InitialPageController extends GetxController {
// double logoSize = 5.0;
  AuthController authController = Get.put(AuthController());

  @override
  void onInit() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      print(authController.userSignedIn.value);
      if (authController.userSignedIn.value) {
        Get.offNamed(Routes.navbar);
      } else {
        Get.offNamed(Routes.login);
      }
    });
    super.onInit();
  }
}

class InitialApiCall extends GetConnect {}
