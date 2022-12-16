class SelectedOrder {
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
  List<Orderdetails>? orderdetails;

  SelectedOrder(
      {this.orderDate,
        this.deliveryCharge,
        this.paymentMode,
        this.orderStatus,
        this.deliveryTimeSlot,
        this.deliveryInstruction,
        this.amount,
        this.deliveryAddress,
        this.customerName,
        this.customerPhonenumber,
        this.orderdetails});

  SelectedOrder.fromJson(Map<String, dynamic> json) {
    orderDate = json['orderDate'];
    deliveryCharge = json['deliveryCharge'];
    paymentMode = json['paymentMode'];
    orderStatus = json['orderStatus'];
    deliveryTimeSlot = json['deliveryTimeSlot'];
    deliveryInstruction = json['deliveryInstruction'];
    amount = json['amount'];
    deliveryAddress = json['deliveryAddress'];
    customerName = json['customerName'];
    customerPhonenumber = json['customerPhonenumber'];
    if (json['orderdetails'] != null) {
      orderdetails = <Orderdetails>[];
      json['orderdetails'].forEach((v) {
        orderdetails!.add(new Orderdetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderDate'] = this.orderDate;
    data['deliveryCharge'] = this.deliveryCharge;
    data['paymentMode'] = this.paymentMode;
    data['orderStatus'] = this.orderStatus;
    data['deliveryTimeSlot'] = this.deliveryTimeSlot;
    data['deliveryInstruction'] = this.deliveryInstruction;
    data['amount'] = this.amount;
    data['deliveryAddress'] = this.deliveryAddress;
    data['customerName'] = this.customerName;
    data['customerPhonenumber'] = this.customerPhonenumber;
    if (this.orderdetails != null) {
      data['orderdetails'] = this.orderdetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orderdetails {
  int? productcode;
  String? productname;
  String? count;
  String? productprice;

  Orderdetails(
      {this.productcode, this.productname, this.count, this.productprice});

  Orderdetails.fromJson(Map<String, dynamic> json) {
    productcode = json['productcode'];
    productname = json['productname'];
    count = json['count'];
    productprice = json['productprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productcode'] = this.productcode;
    data['productname'] = this.productname;
    data['count'] = this.count;
    data['productprice'] = this.productprice;
    return data;
  }
}