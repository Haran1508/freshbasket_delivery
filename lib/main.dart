import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshbasket_delivery_partner/screen/initial/initialpage.scrn.dart';
import 'package:freshbasket_delivery_partner/screen/login/login.dart';
import 'package:freshbasket_delivery_partner/screen/navbar/navbar.scrn.dart';
import 'package:freshbasket_delivery_partner/screen/orderHistory/delivery.update.screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'config/routes.dart';
import 'config/settings.dart';
import 'screen/home/orderDetails.dart';
import 'dart:io' as io;

class MyHttpoverrides extends io.HttpOverrides {
  @override
  io.HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (io.X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  io.HttpOverrides.global = new MyHttpoverrides();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then(
    (_) => runApp(InitialApp()),
  );
}

// ignore: must_be_immutable
class InitialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      enableLog: false,
      defaultTransition: Transition.rightToLeft,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          //textTheme: GoogleFonts.robotoTextTheme()
          appBarTheme:
              AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
          textTheme: GoogleFonts.poppinsTextTheme()),
      initialRoute: Routes.initial,
      getPages: [
        GetPage(
            name: Routes.initial,
            page: () => InitialPage(),
            transition: Transition.zoom),
        // GetPage(name: Routes.home, page: () => HomeScreen(),
        // transition: Transition.rightToLeft
        // ),
        GetPage(name: Routes.navbar, page: () => NavBar()),
        GetPage(name: Routes.orderDetails, page: () => OrderDetails()),
        GetPage(name: Routes.login, page: () => UserLoginScreen()),
        GetPage(
            name: Routes.deliveryScreen, page: () => DeliveryUpdateScreen()),
      ],
    );
  }
}
