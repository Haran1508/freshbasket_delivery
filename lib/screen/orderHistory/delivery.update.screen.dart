import 'package:flutter/material.dart';
import 'package:freshbasket_delivery_partner/config/colors.dart';
import 'package:freshbasket_delivery_partner/config/settings.dart';
import 'package:freshbasket_delivery_partner/config/size.dart';
import 'package:freshbasket_delivery_partner/screen/home/home.ctrl.dart';
import 'package:freshbasket_delivery_partner/screen/home/launchMap.dart';
import 'package:freshbasket_delivery_partner/widgets/widgets.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryUpdateScreen extends StatefulWidget {
  const DeliveryUpdateScreen({Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<DeliveryUpdateScreen> {
  HomeController homeController = Get.find();
  String address = "";

  Widget titleWidget(String title, IconData iconName) {
    return Container(
      color: Colors.grey.shade300.withOpacity(0.8),
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
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
      ),
    );
  }

  @override
  void initState() {
    _getCurrentPosition();
    super.initState();
  }

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();

    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    address = first.addressLine;
    setState(() {});
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

  cancelDialog(BuildContext context) {
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
                          "Cancel Order",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    signInSubTitle("Reason"),
                    textFieldContainer(
                        controller: homeController.cancelController,
                        context: context,
                        hintText: "Write here..."),
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
                            homeController.updateOrder(
                                homeController.selectedOderId.value,
                                "cancelled",
                                "");
                            Get.back();
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
      TextEditingController? controller,
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
        keyboardType: TextInputType.text,
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

  thankyouDialog(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int fontSize = (size.width ~/ 100);
    showDialog(
        context: context,
        builder: (_) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: Builder(
                builder: (context) => Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.03,
                            bottom: size.height * 0.02),
                        child: Title(
                          color: Colors.black,
                          child: Text(
                            "Order Delivered",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: fontSize * 5.8),
                          ),
                        ),
                      ),
                      Text(
                        "Your Order has been Delivered \nsuccessfully",
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: Get.width,
                          height: Get.height * 0.07,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: kPrimaryYellow),
                            onPressed: () async {
                              homeController.updateOrder(
                                  homeController.selectedOderId.value,
                                  "delivered",
                                  "");
                              Get.back();
                            },
                            child: Text("OK"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: sizeSettings.width / 2.5,
                height: sizeSettings.height * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: kPrimaryRed),
                  onPressed: () {
                    cancelDialog(context);
                  },
                  child: Text("Cancel".toUpperCase()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: sizeSettings.width / 2.5,
                height: sizeSettings.height * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: kPrimaryBlack),
                  onPressed: () {
                    thankyouDialog(context);
                  },
                  child: Text("Deliver".toUpperCase()),
                ),
              ),
            ),
          ],
        ),
      ],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: kPrimaryYellow,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kBackgroudColor,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Delivery Detail',
          style: TextStyle(color: kBackgroudColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleWidget("Pickup Location", Icons.location_on_outlined),
              ListTile(
                title: Text("${address}"),
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              titleWidget("Deliver Location", Icons.location_on),
              ListTile(
                title: Text(
                    "${homeController.selectedOrder.value.deliveryAddress}"),
              ),
              Divider(
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
