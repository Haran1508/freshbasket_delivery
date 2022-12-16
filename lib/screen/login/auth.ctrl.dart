import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freshbasket_delivery_partner/config/routes.dart';
import 'package:freshbasket_delivery_partner/config/urls.dart';
import 'package:freshbasket_delivery_partner/model/userModel.dart';
import 'package:freshbasket_delivery_partner/utils/snackbarWidget.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordNewController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController phoneNumbercontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController forgotPhoneController = TextEditingController();
  TextEditingController forgotOTPController = TextEditingController();
  TextEditingController forgotPasswordController = TextEditingController();
  TextEditingController forgotConfirmPasswordController =
      TextEditingController();
  RxBool userSignedIn = false.obs;
  final storage = FlutterSecureStorage();

  String? uid = "";
  String? phone = "";

  UserModel? userModel;

  @override
  void onInit() {
    isUserLoggedIn();
    super.onInit();
  }

  isUserLoggedIn() async {
    uid = await storage.read(key: 'uid');
    phone = await storage.read(key: 'phone');
    userSignedIn.value = (uid != "" && uid != null) ? true : false;
    if (userSignedIn.value == true && uid != null && phone != null) {
      var userDetails = await AuthProvider().fetchUser(uid!, phone!);
      userModel = UserModel.fromMap(userDetails);
    }
  }

  loginUser() async {
    if (phoneNumbercontroller.value.text.trim().length != 10) return;
    if (passwordController.value.text.trim().length < 8) return;
    var result = await AuthProvider().loginUser(
      phoneNumbercontroller.value.text.trim(),
      passwordController.text.trim(),
    );
    if (result != "") {
      await redirectUser(result);
    } else
      errorSnackBar("Error", "Invalid Login Details");
  }

  redirectUser(String _result) async {
    await storage.write(key: 'uid', value: _result);
    await storage.write(key: 'phone', value: phoneNumbercontroller.value.text);
    uid = _result;
    userSignedIn.value = true;
    phone = await storage.read(key: 'phone');
    var userDetails =
        await AuthProvider().fetchUser(uid!, phoneNumbercontroller.value.text);
    userModel = UserModel.fromMap(userDetails);
    if (userModel != null) Get.offNamed(Routes.navbar);
  }

  logoutUser() async {
    if (uid == "") return;
    await storage.delete(key: 'uid');
    userSignedIn.value = false;
    uid = "";
    Get.offNamed(Routes.login);
  }
}

class AuthProvider extends GetConnect {
  Future loginUser(String phonenumber, String password) async {
    try {
      print(phonenumber);
      print(password);
      Map body = {
        "apikey": UrlList.apikey,
        "requestType": UrlList.requestType['namdeliverylogin'],
        "phonenumber": phonenumber,
        "password": password
      };
      final response = await httpClient.request(
          UrlList.endpoints!['login'], "post",
          contentType: "application/json",
          headers: {'Accept': 'application/json'},
          body: body);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var result = jsonDecode(response.body);
        return result['uid'];
      } else {
        errorSnackBar("Error", jsonDecode(response.body));
      }
    } on Exception catch (_) {
      errorSnackBar("Error", "Something went wrong");
    }
    return "";
  }

  Future fetchUser(String uid, String phonenumber) async {
    try {
      Map body = {
        "apikey": UrlList.apikey,
        "requestType": UrlList.requestType['namdeliveryprofile'],
        "phonenumber": phonenumber,
        "uid": uid
      };
      final response = await httpClient.request(
          UrlList.endpoints!['profile'], "post",
          contentType: "application/json",
          headers: {'Accept': 'application/json'},
          body: body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else
        errorSnackBar("Error", "Improper details");
    } on Exception catch (_) {
      errorSnackBar("Error", "Something went wrong");
    }
    return "";
  }
}
