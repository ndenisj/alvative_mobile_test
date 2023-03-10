import 'dart:convert';

PayWithNewTypeRequestEntity payWithNewTypeRequestEntityFromJson(String str) =>
    PayWithNewTypeRequestEntity.fromJson(json.decode(str));

String payWithNewTypeRequestEntityToJson(PayWithNewTypeRequestEntity data) =>
    json.encode(data.toJson());

class PayWithNewTypeRequestEntity {
  PayWithNewTypeRequestEntity({
    required this.type,
    required this.email,
    required this.amount,
  });

  String type;
  String email;
  int amount;

  factory PayWithNewTypeRequestEntity.fromJson(Map<String, dynamic> json) =>
      PayWithNewTypeRequestEntity(
        type: json["type"],
        email: json["email"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "email": email,
        "amount": amount,
      };
}
