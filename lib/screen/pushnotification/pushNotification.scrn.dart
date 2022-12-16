import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:freshbasket_delivery_partner/config/colors.dart';
import 'package:freshbasket_delivery_partner/config/routes.dart';
import 'package:freshbasket_delivery_partner/config/size.dart';
import 'package:freshbasket_delivery_partner/screen/home/home.ctrl.dart';
import 'package:get/get.dart';

class PushNotification extends StatefulWidget {
  const PushNotification({Key? key}) : super(key: key);

  @override
  _PushNotificationState createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  HomeController homeController = Get.find();

  @override
  void initState() {
    homeController.fetchNotificationList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: kPrimaryYellow,
          title: Text(
            'Notifications',
            style: TextStyle(color: kBackgroudColor),
          ),
        ),
        body: Obx(() => homeController.notificationList.length == 0
            ? onOrdersWidget(20)
            : notificationList()));
  }

  Widget notificationList() {
    return ListView.builder(
        itemCount: homeController.notificationList.length,
        itemBuilder: (_, index) {
          if (homeController.notificationList[index].deleted == "0")
            return Container(
              height: sizeSettings.height * 0.15,
              width: sizeSettings.width,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              decoration: BoxDecoration(color: kBackgroudColor, boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200, blurRadius: 3, spreadRadius: 2)
              ]),
              child: Row(
                children: [
                  vehicleIcon(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          /*TextSpan(
                            text: "Order #4762",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.black),
                          ),*/
                          TextSpan(
                            text:
                                "${homeController.notificationList[index].content}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                        ])),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${homeController.notificationList[index].createdDate}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.normal),
                            ),
                            /* IconButton(
                              padding: EdgeInsets.all(0),
                              color: kPrimaryYellow,
                              splashColor: Colors.grey,
                              onPressed: () {},
                              icon: Container(
                                height: 40,
                                width: 40,
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.delete,
                                  color: kPrimaryRed,
                                ),
                              ),
                            )*/
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  )
                ],
              ),
            );
          else
            return Container();
        });
  }

  Widget onOrdersWidget(double fontSize) {
    return Center(
      child: Text(
        "No orders found!",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget vehicleIcon() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: kPrimaryYellow, borderRadius: BorderRadius.circular(100)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            MaterialIcons.delivery_dining,
            color: kBackgroudColor,
            size: 40,
          ),
        ),
      ),
    );
  }
}
