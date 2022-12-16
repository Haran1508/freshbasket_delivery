import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:freshbasket_delivery_partner/config/colors.dart';
import 'package:freshbasket_delivery_partner/config/routes.dart';
import 'package:freshbasket_delivery_partner/config/settings.dart';
import 'package:freshbasket_delivery_partner/config/size.dart';
import 'package:freshbasket_delivery_partner/screen/home/home.ctrl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'tabs/activeOrders.dart';

class HomeScreen extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();

  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return true;
  }

  Widget appBar(BuildContext context) {
    return Container(
      width: sizeSettings.width,
      height: sizeSettings.height / 5,
      color: kPrimaryYellow,
      child: Padding(
        padding: EdgeInsets.only(left: 8, right: 8, top: 50, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Namma Fresh Basket",
              style:
                  textSettings.titleTextStyle.copyWith(color: kBackgroudColor),
            ),
            Text(
              "Delivery Partner",
              style: TextStyle(color: kBackgroudColor, fontSize: 16),
            ),
            // searchBox(onPress: () {})
          ],
        ),
      ),
    );
  }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 40,
            child: TabBar(
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: sizeSettings.blockWidth * 4),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(45)),
                unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: sizeSettings.blockWidth * 3.5),
                isScrollable: false,
                tabs: [
                  Tab(text: "Active"),
                  Tab(text: "Delivered"),
                  Tab(text: "Cancelled"),
                ]),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            child:
                TabBarView(physics: NeverScrollableScrollPhysics(), children: [
              ActiveOrders(),
              Container(
                child: Text("Delivered"),
              ),
              Container(
                child: Text("Cancelled"),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget searchBox({required Function onPress}) {
    return Container(
      height: sizeSettings.blockWidth * 15,
      width: sizeSettings.fullWidth,
      color: kPrimaryYellow,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 40,
        width: sizeSettings.fullWidth,
        decoration: BoxDecoration(
            color: kBackgroudColor, borderRadius: BorderRadius.circular(30)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onPress(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Text(searchText),
                  Spacer(),
                  Icon(
                    Ionicons.md_search_outline,
                    size: 28,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget titleWidget(String title, IconData iconName) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 15),
          child: Icon(iconName),
        ),
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kPrimaryBlack,
              fontSize: sizeSettings.blockWidth * 4.5),
        ),
      ],
    );
  }

  Widget activeOrderList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: homeController.assignedOrderList.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Card(
              elevation: 2.0,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  children: [
                    Container(
                      height: sizeSettings.blockWidth * 15,
                      width: sizeSettings.blockWidth * 15,
                      child: /*FadeInImage.assetNetwork(
                          placeholder: appLogoGrey,
                          image:
                              "https://www.greenmainfotech.com/app_images/C1.png")*/
                          Image.asset(appLogoGrey, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Id: #${homeController.assignedOrderList[index].orderid}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: sizeSettings.width / 2,
                            child: Text(
                                "${homeController.assignedOrderList[index].deliveryAddress}"),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            "Rs. ${homeController.assignedOrderList[index].amount}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Material(
                          color: kPrimaryYellow,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                            padding: EdgeInsets.all(0),
                            color: kPrimaryYellow,
                            splashColor: Colors.grey,
                            onPressed: () {
                              homeController.setSelectedOrderId(homeController
                                  .assignedOrderList[index].orderid!
                                  .toString());
                              Get.toNamed(Routes.orderDetails);
                            },
                            icon: Container(
                              height: 80,
                              width: 80,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: kBackgroudColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentPosition();
    return Scaffold(
      body: Container(
        height: sizeSettings.height,
        width: sizeSettings.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              appBar(context),
              SizedBox(
                height: 10,
              ),
              // _tabSection(context)
              titleWidget("Assigned Order", Icons.av_timer),
              Obx(() => homeController.assignedOrderList.length == 0
                  ? onOrdersWidget(20)
                  : activeOrderList())
            ],
          ),
        ),
      ),
    );
  }

  Container onOrdersWidget(double fontSize) {
    return Container(
      height: sizeSettings.fullHeight,
      child: Center(
        child: Text(
          "No orders found!",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
