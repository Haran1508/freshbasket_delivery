import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:freshbasket_delivery_partner/config/colors.dart';
import 'package:freshbasket_delivery_partner/config/settings.dart';
import 'package:freshbasket_delivery_partner/config/size.dart';
import 'package:freshbasket_delivery_partner/screen/login/auth.ctrl.dart';
import 'package:freshbasket_delivery_partner/screen/profile/profile.ctrl.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  // ProfileController profileController = Get.put(ProfileController());
  AuthController authController = Get.find();

  Widget listCard(String title, bool isIcon, VoidCallback onPress,
      {IconData icon = Icons.error,
      String imageName = "",
      String subTitle = "",
      String thirdSubtitle = "",
      String secondSubTitle = "",
      bool isSubtitle = false}) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        isThreeLine: true,
        onTap: onPress,
        leading: (isIcon)
            ? Icon(
                icon,
                color: Colors.grey.shade500,
              )
            : Image.asset(
                userIcon,
                color: Colors.grey,
                height: 20,
              ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$subTitle, $secondSubTitle"),
            Text("$thirdSubtitle"),
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: kPrimaryBlack,
        ),
      ),
    );
  }

  accountBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        elevation: 5.0,
        isScrollControlled: true,
        barrierColor: kPrimaryYellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        backgroundColor: kBackgroudColor,
        context: context,
        builder: (context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Update Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          child: IconButton(
                              onPressed: () => Get.back(),
                              icon: Icon(
                                Icons.close,
                                color: kPrimaryBlack,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "First Name"),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Last Name"),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Email Address"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Phone Number"),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width * 0.98,
                      decoration: BoxDecoration(
                        color: kPrimaryBlack,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Update",
                        style: TextStyle(color: kBackgroudColor),
                      ),
                    ),
                  ),
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile Details",
          style: TextStyle(color: kBackgroudColor),
        ),
        elevation: 0.0,
        backgroundColor: kPrimaryYellow,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios, color: kBackgroudColor)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: sizeSettings.fullHeight * 0.30,
              width: sizeSettings.fullWidth,
              color: kPrimaryYellow,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Spacer(),
                  Container(
                    child: Image.asset(
                      userIcon,
                      color: kPrimaryBlack.withOpacity(0.8),
                    ),
                    padding: EdgeInsets.all(25),
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      authController.userModel!.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kBackgroudColor),
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                listCard(
                    "Profile Details", false, () => accountBottomSheet(context),
                    imageName: userIcon,
                    subTitle: authController.userModel!.name,
                    secondSubTitle: authController.phone ?? "",
                    thirdSubtitle: authController.userModel!.email),
                // listCard(
                //   "My ",
                //   true,
                //   () {},
                //   icon: Ionicons.location_outline,
                //   subTitle: "No Address",
                // ),
                listCard("Privacy Policy", true, () {},
                    icon: MaterialIcons.privacy_tip),
                listCard("Terms & Conditions", true, () {},
                    icon: MaterialCommunityIcons.watermark),
                listCard("LogOut", true, () {
                  authController.logoutUser();
                }, icon: AntDesign.logout),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
