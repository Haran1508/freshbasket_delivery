import 'package:flutter/material.dart';
import 'package:freshbasket_delivery_partner/config/colors.dart';
import 'package:freshbasket_delivery_partner/screen/navbar/navbar.ctrl.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class NavBar extends StatelessWidget {
  NavbarController navbarController = Get.put(NavbarController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: kPrimaryYellow,
          showSelectedLabels: true,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          selectedIconTheme: IconThemeData(color: Colors.white, size: 30),
          unselectedIconTheme: IconThemeData(color: Colors.white54),
          type: BottomNavigationBarType.fixed,
          onTap: (index) => navbarController.onTap(index),
          currentIndex: navbarController.currentIndex.value,
          items: [
            BottomNavigationBarItem(icon: new Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: new Icon(Icons.av_timer), label: "Order History"),
            BottomNavigationBarItem(
                icon: new Icon(Icons.notifications), label: "Notification"),
            BottomNavigationBarItem(
                icon: new Icon(Icons.person), label: "Profile"),
          ],
        ),
        body: navbarController.pages[navbarController.currentIndex.value],
      ),
    );
  }
}
