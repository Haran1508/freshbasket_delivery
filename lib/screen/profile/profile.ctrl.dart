import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:freshbasket_delivery_partner/model/userModel.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController email = TextEditingController();

  late UserModel? userModel;

  String? name;
  String? phone;
  String? emailId;
  String? address;

  @override
  void onInit() {
    fetchUser();
    super.onInit();
  }

  fetchUser() async {
    print("here..");
    // print(userModel!.address);
  }
}
