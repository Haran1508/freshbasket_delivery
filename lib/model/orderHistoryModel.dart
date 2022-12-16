import 'dart:convert';

class OrderHistoryModel {
  int? orderId;
  String? orderDate;
  String? deliveryCharge;
  String? paymentMode;
  String? orderStatus;
  String? deliveryTimeSlot;
  String? deliveryInstruction;
  String? amount;
  String? deliveryAddress;
  String? customerName;
  String? customerPhonenumber;

  OrderHistoryModel(
      {this.orderId,
      this.orderDate,
      this.deliveryCharge,
      this.paymentMode,
      this.orderStatus,
      this.deliveryTimeSlot,
      this.deliveryInstruction,
      this.amount,
      this.deliveryAddress,
      this.customerName,
      this.customerPhonenumber});

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'orderDate': orderDate,
      'deliveryCharge': deliveryCharge,
      'paymentMode': paymentMode,
      'orderStatus': orderStatus,
      'deliveryTimeSlot': deliveryTimeSlot,
      'deliveryInstruction': deliveryInstruction,
      'amount': amount,
      'deliveryAddress': deliveryAddress,
      'customerName': customerName,
      'customerPhonenumber': customerPhonenumber,
    };
  }

  factory OrderHistoryModel.fromMap(Map<String, dynamic> map) {
    return OrderHistoryModel(
      orderId: map['orderId']?.toInt() ?? 0,
      orderDate: map['orderDate'] ?? '',
      deliveryCharge: map['deliveryCharge'] ?? '',
      paymentMode: map['paymentMode'] ?? '',
      orderStatus: map['orderStatus'] ?? '',
      deliveryTimeSlot: map['deliveryTimeSlot'] ?? '',
      deliveryInstruction: map['deliveryInstruction'] ?? '',
      amount: map['amount'] ?? '',
      deliveryAddress: map['deliveryAddress'] ?? '',
      customerName: map['customerName'] ?? '',
      customerPhonenumber: map['customerPhonenumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderHistoryModel.fromJson(String source) =>
      OrderHistoryModel.fromMap(json.decode(source));
}
