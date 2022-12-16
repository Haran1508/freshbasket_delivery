import 'dart:convert';

class NotificationModel {
  int? id;
  String? content;
  String? orderid;
  String? deleted;
  String? createdDate;
  String? updatedDate;

  NotificationModel(
      {this.id,
      this.content,
      this.orderid,
      this.deleted,
      this.createdDate,
      this.updatedDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'orderid': orderid,
      'deleted': deleted,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id']?.toInt() ?? 0,
      content: map['content'] ?? '',
      orderid: map['orderid'] ?? '',
      deleted: map['deleted'] ?? '',
      createdDate: map['createdDate'] ?? '',
      updatedDate: map['updatedDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));
}
