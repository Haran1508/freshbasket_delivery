import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:freshbasket_delivery_partner/config/routes.dart';
import 'package:freshbasket_delivery_partner/config/urls.dart';
import 'package:freshbasket_delivery_partner/model/assigned.orders.dart';
import 'package:freshbasket_delivery_partner/model/notificationModel.dart';
import 'package:freshbasket_delivery_partner/model/orderHistoryModel.dart';
import 'package:freshbasket_delivery_partner/model/selectedOrderModel.dart';
import 'package:freshbasket_delivery_partner/screen/login/auth.ctrl.dart';
import 'package:freshbasket_delivery_partner/utils/snackbarWidget.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  AuthController authController = Get.find();

  // AuthController authController = Get.put(AuthController());
  RxList<AssignedOrders> assignedOrderList = <AssignedOrders>[].obs;
  RxList<OrderHistoryModel> orderHistoryList = <OrderHistoryModel>[].obs;
  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;

  TextEditingController cancelController = TextEditingController();

  Rx<String> selectedOderId = "".obs;
  Rx<SelectedOrder> selectedOrder = SelectedOrder().obs;

  @override
  void onInit() {
    fetchHomeScreenData();
    // fetchOrderHistoryData();
    super.onInit();
  }

  fetchSelectedOrder(String id) async {
    selectedOrder.value = await HomeRepository().orderFetchPaticular(
        authController.uid!, int.parse(id), authController.phone!);
  }

  setSelectedOrderId(String orderId) {
    selectedOderId.value = orderId;
  }

  fetchHomeScreenData() async {
    assignedOrderList.value = await HomeRepository()
        .fetchAssignedOrders(authController.phone, authController.uid);
  }

  fetchOrderHistoryData() async {
    orderHistoryList.value = await HomeRepository()
        .fetchOrderHistory(authController.phone, authController.uid);
  }

  fetchNotificationList() async {
    notificationList.value = await HomeRepository()
        .fetchNotification(authController.phone, authController.uid);
  }

  updateOrder(String? orderId, String? status, String? reson) async {
    if (status == "cancelled") reson = cancelController.text.toString().trim();
    bool value = await HomeRepository().updateOrder(
        authController.phone, authController.uid, orderId, status, reson);
    if (value) {
      Get.back();
      // successSnackBar("Success", "Order Updated Successfully");
    }
  }
}

class HomeRepository extends GetConnect {
  Future fetchAssignedOrders(String? phone, String? uid) async {
    List<AssignedOrders> categories = [];
    try {
      final response = await httpClient.request(
          UrlList.endpoints!['assignedOrders'], "post",
          contentType: "application/json",
          headers: {
            'Accept': 'application/json'
          },
          body: {
            "apikey": UrlList.apikey,
            "phonenumber": phone,
            "uid": uid,
            "requestType": UrlList.requestType['namdeliveryassignedorders']
          });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var data = result as List;
        data.forEach(
            (element) => categories.add(AssignedOrders.fromMap(element)));
        return categories;
      } else
        errorSnackBar("Error", "Something went wrong");
    } on Exception catch (_) {
      errorSnackBar("Error", "Something went wrong");
    }
    return categories;
  }

  Future fetchOrderHistory(String? phone, String? uid) async {
    List<OrderHistoryModel> categories = [];
    try {
      final response = await httpClient.request(
          UrlList.endpoints!['orderHistory'], "post",
          contentType: "application/json",
          headers: {
            'Accept': 'application/json'
          },
          body: {
            "apikey": UrlList.apikey,
            "phonenumber": phone,
            "uid": uid,
            "requestType": UrlList.requestType['namdeliveryorderhistory']
          });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var data = result as List;
        data.forEach(
            (element) => categories.add(OrderHistoryModel.fromMap(element)));
        return categories;
      } else
        errorSnackBar("Error", "Something went wrong");
    } on Exception catch (_) {
      errorSnackBar("Error", "Something went wrong");
    }
    return categories;
  }

  Future fetchNotification(String? phone, String? uid) async {
    List<NotificationModel> categories = [];
    try {
      final response = await httpClient.request(
          UrlList.endpoints!['notifications'], "post",
          contentType: "application/json",
          headers: {
            'Accept': 'application/json'
          },
          body: {
            "apikey": UrlList.apikey,
            "phonenumber": phone,
            "uid": uid,
            "requestType": UrlList.requestType['namdeliverynotifications']
          });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var data = result as List;
        data.forEach(
            (element) => categories.add(NotificationModel.fromMap(element)));
        return categories;
      } else
        errorSnackBar("Error", "Something went wrong");
    } on Exception catch (_) {
      errorSnackBar("Error", "Something went wrong");
    }
    return categories;
  }

  Future orderFetchPaticular(String uid, int orderId, String phone) async {
    SelectedOrder selectedOrder;
    try {
      Map body = {
        "apikey": UrlList.apikey,
        "requestType": UrlList.requestType['namdeliveryorderrequest'],
        "phonenumber": phone,
        "uid": uid,
        "orderid": orderId
      };
      final response = await httpClient.request(
          UrlList.endpoints!['orders'], "post",
          contentType: "application/json",
          headers: {'Accept': 'application/json'},
          body: body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        selectedOrder = SelectedOrder.fromJson(result);
        return selectedOrder;
      }
    } on Exception catch (e) {
      print(e);
      return "";
    }
  }

  Future updateOrder(String? phone, String? uid, String? orderId,
      String? status, String? reson) async {
    try {
      final response = await httpClient.request(
          UrlList.endpoints!['updateOrder'], "post",
          contentType: "application/json",
          headers: {
            'Accept': 'application/json'
          },
          body: {
            "apikey": UrlList.apikey,
            "phonenumber": phone,
            "uid": uid,
            "orderid": orderId,
            "status": status,
            "reason": reson,
            "requestType": UrlList.requestType['namdeliveryupdateorder'],
          });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return true;
      } else
        errorSnackBar("Error", "Something went wrong");
    } on Exception catch (_) {
      print(_);
      errorSnackBar("Error", "Something went wrong");
    }
    return false;
  }
}
