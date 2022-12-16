import 'package:flutter/material.dart';
import 'package:freshbasket_delivery_partner/config/colors.dart';
import 'package:freshbasket_delivery_partner/config/size.dart';
import 'package:freshbasket_delivery_partner/screen/home/home.ctrl.dart';
import 'package:get/get.dart';

class OrdersHistory extends StatefulWidget {
  const OrdersHistory({Key? key}) : super(key: key);

  @override
  _OrdersHistoryState createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  HomeController homeController = Get.find();

  @override
  void initState() {
    homeController.fetchOrderHistoryData();
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
          'Order History',
          style: TextStyle(color: kBackgroudColor),
        ),
      ),
      body: Obx(() => homeController.assignedOrderList.length == 0
          ? onOrdersWidget(20)
          : orderhistoryList()),
    );
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

  Widget orderhistoryList() {
    return ListView.separated(
        itemCount: homeController.orderHistoryList.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (_, index) => Divider(
              thickness: 1,
            ),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {},
            isThreeLine: true,
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                homeController.orderHistoryList[index].orderDate
                    .toString()
                    .trim(),
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: Colors.black87),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Order ID : #" +
                      homeController.orderHistoryList[index].orderId.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black),
                ),
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    homeController.orderHistoryList[index].orderStatus
                        .toString()
                        .capitalizeFirst!,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.green)),
                Text(
                    "Rs : " +
                        homeController.orderHistoryList[index].amount
                            .toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black)),
              ],
            ),
          );
        });
  }
}
