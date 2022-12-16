import 'dart:convert';

class AssignedOrders {
  int? orderid;
  String? amount;
  String? orderDate;
  String? deliveryAddress;
  String? paymentMode;
  String? orderStatus;

  AssignedOrders(
      {this.orderid,
      this.amount,
      this.orderDate,
      this.deliveryAddress,
      this.paymentMode,
      this.orderStatus});

  Map<String, dynamic> toMap() {
    return {
      'orderid': orderid,
      'amount': amount,
      'orderDate': orderDate,
      'deliveryAddress': deliveryAddress,
      'paymentMode': paymentMode,
      'orderStatus': orderStatus,
    };
  }

  factory AssignedOrders.fromMap(Map<String, dynamic> map) {
    return AssignedOrders(
      orderid: map['orderid']?.toInt() ?? 0,
      amount: map['amount'] ?? '',
      orderDate: map['orderDate'] ?? '',
      deliveryAddress: map['deliveryAddress'] ?? '',
      paymentMode: map['paymentMode'] ?? '',
      orderStatus: map['orderStatus'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignedOrders.fromJson(String source) =>
      AssignedOrders.fromMap(json.decode(source));
}
