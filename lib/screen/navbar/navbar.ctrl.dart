import 'package:freshbasket_delivery_partner/screen/home/home.scrn.dart';
import 'package:freshbasket_delivery_partner/screen/orderHistory/orders.scrn.dart';
import 'package:freshbasket_delivery_partner/screen/profile/profile.scrn.dart';
import 'package:freshbasket_delivery_partner/screen/pushnotification/pushNotification.scrn.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  RxInt currentIndex = 0.obs;

  List pages = [
    HomeScreen(),
    OrdersHistory(),
    PushNotification(),
    ProfileScreen(),
  ];

  onTap(int index) => currentIndex.value = index;
}
