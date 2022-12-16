import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freshbasket_delivery_partner/config/colors.dart';
import 'package:freshbasket_delivery_partner/config/size.dart';
import 'package:freshbasket_delivery_partner/screen/login/auth.ctrl.dart';
import 'package:get/get.dart';

class UserLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SecondLoginDesign(),
    );
  }
}

// ignore: must_be_immutable
class SecondLoginDesign extends StatelessWidget {
  AuthController authController = Get.put(AuthController());

  forgetPasswordDialog(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Builder(
              builder: (context) => Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.02, bottom: size.height * 0.02),
                      child: Title(
                        color: Colors.black,
                        child: Text(
                          "Registered Phone Number",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    //signInSubTitle("Phone Number"),
                    textFieldContainer(
                        controller: authController.forgotPhoneController,
                        context: context,
                        hintText: "XXXXX XXXXX"),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: Get.width,
                        height: Get.height * 0.07,
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: kPrimaryYellow),
                          onPressed: () async {
                            /*bool result =
                            await authController.forgetPhoneNumber();
                            if (result) {
                              otpDialogbox(context);
                            }*/
                          },
                          child: Text("Reset Password"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  resetPassword(context) {
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Builder(
              builder: (context) => Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.02, bottom: size.height * 0.02),
                      child: Title(
                        color: Colors.black,
                        child: Text(
                          "Reset Password",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    signInSubTitle("Password"),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldContainer(
                        controller: authController.forgotPasswordController,
                        context: context,
                        hintText: "Password"),
                    SizedBox(
                      height: 10,
                    ),
                    signInSubTitle("Confirm Password"),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldContainer(
                        controller:
                            authController.forgotConfirmPasswordController,
                        context: context,
                        hintText: "Confirm Password"),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: Get.width,
                        height: Get.height * 0.07,
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: kPrimaryYellow),
                          onPressed: () async {
                            /*  bool result = await authController.resetPassword();
                            if (result) {
                              Navigator.of(context, rootNavigator: true).pop();
                              Get.toNamed('/userlogin');
                            }*/
                          },
                          child: Text("Submit"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  otpDialogbox(context) {
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Builder(
              builder: (context) => Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.02, bottom: size.height * 0.02),
                      child: Title(
                        color: Colors.black,
                        child: Text(
                          "OTP Number",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // signInSubTitle(
                    //     "Please enter your otp number in below box - ${authController.otp}"),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldContainer(
                        controller: authController.forgotOTPController,
                        context: context,
                        hintText: "XXXX"),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: Get.height * 0.07,
                            width: Get.width * 0.25,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey.shade200),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text("Cancel",
                                  style: TextStyle(color: kPrimaryYellow)),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: Get.height * 0.07,
                            width: Get.width * 0.25,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: kPrimaryYellow),
                              onPressed: () async {
                                /*bool result = await authController
                                    .forgetPhoneNumberWithOTP();
                                if (result) {
                                  resetPassword(context);
                                }*/
                              },
                              child: Text("Submit"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Align signInSubTitle(String subTitle) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 3),
          child: Text(
            subTitle,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
  }

  Container textFieldContainer(
      {required BuildContext context,
      required String hintText,
      bool trailing = false,
      required TextEditingController controller,
      IconData endIcon = Icons.visibility}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.15),
                spreadRadius: 4,
                blurRadius: 5)
          ]),
      child: TextField(
        cursorHeight: 22,
        controller: controller,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            suffixIcon: AbsorbPointer(
              absorbing: (trailing == true) ? false : true,
              child: Material(
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    endIcon,
                    color:
                        (trailing == true) ? Colors.grey : Colors.transparent,
                  ),
                ),
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroudColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: Get.height * 0.04)),
            SizedBox(
              height: 20,
            ),
            Container(
              height: sizeSettings.fullWidth * 0.35,
              width: sizeSettings.fullWidth * 0.35,
              decoration: BoxDecoration(
                  color: kPrimaryYellow.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100)),
              child: Icon(
                Icons.person,
                color: kPrimaryYellow,
                size: sizeSettings.blockWidth * 25,
              ),
            ),
            Text(
              "DeliveryBoy Login",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: (Get.width / 100) * 5),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Please enter your registered phone number and password",
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 60,
              width: Get.width * 0.95,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "+91",
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: 20,
                      width: 1.5,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: authController.phoneNumbercontroller,
                      keyboardType: TextInputType.phone,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 2),
                        hintText: "Enter your phone number",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: (Get.width / 100) * 3.5),
            Container(
              height: 60,
              width: Get.width * 0.95,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
                controller: authController.passwordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter your password",
                ),
              ),
            ),
            SizedBox(height: (Get.width / 100) * 5),
            /* SizedBox(height: (Get.width / 100) * 2),
            Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () => forgetPasswordDialog(context),
                    child: Text(
                      "Forget Password",
                      style: TextStyle(color: kPrimaryYellow),
                    ))),*/
            SizedBox(height: (Get.width / 100) * 2),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: Get.width,
                height: Get.height * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: kPrimaryYellow),
                  onPressed: () {
                    authController.loginUser();
                  },
                  child: Text("Login"),
                ),
              ),
            ),
            SizedBox(height: (Get.width / 100) * 2),
            /*TextButton(
                onPressed: () => Get.toNamed('/phoneAuth'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: kPrimaryBlack),
                    ),
                    Text(
                      "Register Here",
                      style: TextStyle(color: kPrimaryYellow),
                    ),
                  ],
                )),*/
          ],
        ),
      ),
    );
  }
}
