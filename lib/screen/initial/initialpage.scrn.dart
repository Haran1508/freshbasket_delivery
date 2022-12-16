import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:freshbasket_delivery_partner/config/colors.dart';
import 'package:freshbasket_delivery_partner/config/settings.dart';
import 'package:freshbasket_delivery_partner/config/size.dart';
import 'package:freshbasket_delivery_partner/config/sizeConfig.dart';

// import 'package:freshbasket/config/colors.dart';
// import 'package:freshbasket/config/settings.dart';
// import 'package:freshbasket/config/sizeConfig.dart';
// import 'package:freshbasket/screens/initial/initialpage.ctrl.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'initialpage.ctrl.dart';

// ignore: must_be_immutable
class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  InitialPageController initialPageController =
  Get.put(InitialPageController());

  final BoxDecoration boxDecoration = BoxDecoration(
      gradient: LinearGradient(
          colors: [kPrimaryYellow, kPrimaryLightGreen],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter));

  final BoxDecoration boxDecoration1 = BoxDecoration(
      gradient: LinearGradient(
          colors: [kPrimaryYellow, kPrimaryRed],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter));

  final BoxDecoration boxDecoration2 = BoxDecoration(
      color: kBackgroudColor, borderRadius: BorderRadius.circular(100));

  final BoxDecoration boxDecoration3 = BoxDecoration(
      gradient: LinearGradient(
          colors: [kPrimaryRed, kPrimaryRed],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter));

  // ignore: unused_field
  double _opacity = 0.0;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroudColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: sizeSettings.fullWidth * 0.8,
                  height: sizeSettings.fullHeight * 0.3,
                  child: Image.asset("assets/bg2.png", fit: BoxFit.cover),
                ),
                Text("Nama FreshBasket",
                    style: GoogleFonts.carterOne(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryYellow,
                      fontSize: sizeSettings.blockWidth * 6,
                    )),
                Text(
                  "Your one stop destiny for all Groceries",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: sizeSettings.blockWidth * 2.5,
                      color: kPrimaryYellow,
                      letterSpacing: 1.2),
                ),
              ],
            ),
          ),
          LoaderWidget()
        ],
      ),
    );
  }
}

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Container(
          height: sizeSettings.fullHeight,
          width: sizeSettings.fullWidth,
          alignment: Alignment.center,
          color: Colors.grey.withOpacity(0.5),
          child: Container(
            padding: EdgeInsets.all(10),
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: SpinKitDualRing(
                color: kPrimaryYellow,
                lineWidth: 3,
                size: 28,
              ),
            ),
          ),
        ));
  }
}
