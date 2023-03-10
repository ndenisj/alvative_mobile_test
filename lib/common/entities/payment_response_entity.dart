import 'dart:convert';

PaymentResponseEntity paymentResponseEntityFromJson(String str) =>
    PaymentResponseEntity.fromJson(json.decode(str));

String paymentResponseEntityToJson(PaymentResponseEntity data) =>
    json.encode(data.toJson());

class PaymentResponseEntity {
  PaymentResponseEntity({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory PaymentResponseEntity.fromJson(Map<String, dynamic> json) =>
      PaymentResponseEntity(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.status,
    this.reference,
    this.amount,
    this.message,
  });

  int? id;
  String? status;
  String? reference;
  int? amount;
  dynamic message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        status: json["status"],
        reference: json["reference"],
        amount: json["amount"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "reference": reference,
        "amount": amount,
        "message": message,
      };
}
