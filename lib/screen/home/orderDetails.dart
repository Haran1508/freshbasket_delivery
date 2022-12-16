import 'package:flutter/material.dart';
import 'package:freshbasket_delivery_partner/config/colors.dart';
import 'package:freshbasket_delivery_partner/config/routes.dart';
import 'package:freshbasket_delivery_partner/config/settings.dart';
import 'package:freshbasket_delivery_partner/config/size.dart';
import 'package:freshbasket_delivery_partner/screen/home/home.ctrl.dart';
import 'package:freshbasket_delivery_partner/screen/home/launchMap.dart';
import 'package:freshbasket_delivery_partner/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  HomeController homeController = Get.find();

  Widget customerDetail() {
    return Container(
      //color: Colors.grey.shade100,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customerRow("${homeController.selectedOrder.value.customerName}",
              Icons.person),
          customerRow(
            "${homeController.selectedOrder.value.deliveryAddress}",
            Icons.location_on,
            () {
              /* MapsLauncher.launchCoordinates(13.0827, 80.2707)
                  .onError((error, stackTrace) {
                return errorSnackBar("Error", "Can't find location...");
              });*/
            },
            true,
          ),
          customerRow(
            "${homeController.selectedOrder.value.customerPhonenumber}",
            Icons.phone_android_rounded,
            () async {
              await launch(
                  "tel: ${homeController.selectedOrder.value.customerPhonenumber}");
            },
            true,
          ),
        ],
      ),
    );
  }

  Widget customerRow(String title, IconData iconName,
      [VoidCallback? onPress, bool active = false]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(title)),
        IconButton(
            onPressed: onPress,
            icon: Icon(iconName,
                color: active ? kPrimaryRed : Colors.grey.shade400))
      ],
    );
  }

  Widget orderId() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: kPrimaryYellow.withOpacity(0.8),
                borderRadius: BorderRadius.circular(25)),
            child: Icon(
              Icons.schedule_outlined,
              color: kBackgroudColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Id # ${homeController.selectedOderId.value}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('${homeController.selectedOrder.value.paymentMode}'),
                Text('${homeController.selectedOrder.value.orderDate}'),
              ],
            ),
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rs. ${homeController.selectedOrder.value.amount}',
                  style: TextStyle(
                      color: kPrimaryBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              if (homeController.selectedOrder.value.orderdetails != null)
                Text(
                    'items ${homeController.selectedOrder.value.orderdetails!.length.toString()}',
                    style: TextStyle(
                        color: kPrimaryBlack.withOpacity(0.4),
                        fontWeight: FontWeight.normal,
                        fontSize: 15)),
            ],
          )
        ],
      ),
    );
  }

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

  Widget itemsList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: homeController.selectedOrder.value.orderdetails!.length,
        itemBuilder: (_, index) {
          return ListTile(
            isThreeLine: true,
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Rs. ${homeController.selectedOrder.value.orderdetails![index].productprice ?? ""}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // Text("2021-07-01"),
              ],
            ),
            title: Text(
                "${homeController.selectedOrder.value.orderdetails![index].productname ?? ""}"),
            subtitle: Text(
                "Quantity: ${homeController.selectedOrder.value.orderdetails![index].count ?? ""}"),
            leading: Container(
              height: sizeSettings.blockWidth * 15,
              width: sizeSettings.blockWidth * 15,
              child: /*FadeInImage.assetNetwork(
                  placeholder: appLogoGrey,
                  image: "https://www.greenmainfotech.com/app_images/C1.png")*/
                  Image.asset(appLogoGrey, fit: BoxFit.cover),
            ),
          );
        });
  }

  Widget amountWidget() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        titleWidget("Payment Details", Icons.payment),
        ListTile(
          title: Text("Sub Total"),
          trailing: Text("Rs. ${homeController.selectedOrder.value.amount}"),
        ),
        ListTile(
          title: Text("Delivery Charge"),
          trailing: Text("Rs. 0"),
        ),
        ListTile(
          title: Text("Tax"),
          trailing: Text("Rs. 0"),
        ),
        Divider(
          thickness: 1.5,
        ),
        ListTile(
          minVerticalPadding: 0,
          title: Text(
            "Total",
            style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryRed),
          ),
          subtitle: Text("Amount need to pay"),
          trailing: Text(
            "Rs. ${homeController.selectedOrder.value.amount}",
            style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryRed),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    await homeController
        .fetchSelectedOrder(homeController.selectedOderId.value);
    print(homeController.selectedOrder.value.amount);
    setState(() {});
  }

  String? getButtonName() {
    return "Accept";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: sizeSettings.width,
            height: sizeSettings.height * 0.07,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: kPrimaryBlack),
              onPressed: () {
                Get.offNamed(Routes.deliveryScreen);
              },
              child: Text(getButtonName()!.toUpperCase()),
            ),
          ),
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
          'Order Detail',
          style: TextStyle(color: kBackgroudColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            orderId(),
            Divider(
              thickness: 2,
            ),
            titleWidget("Customer Detail", Icons.location_history),
            customerDetail(),
            Divider(
              thickness: 2,
            ),
            titleWidget("Item List", Icons.shopping_bag),
            if (homeController.selectedOrder.value.orderdetails != null)
              itemsList(),
            Divider(
              thickness: 2,
            ),
            amountWidget()
          ],
        ),
      ),
    );
  }
}
