import 'dart:convert';

PayWithSavedCardRequestEntity payWithSavedCardRequestEntityFromJson(
        String str) =>
    PayWithSavedCardRequestEntity.fromJson(json.decode(str));

String payWithSavedCardRequestEntityToJson(
        PayWithSavedCardRequestEntity data) =>
    json.encode(data.toJson());

class PayWithSavedCardRequestEntity {
  PayWithSavedCardRequestEntity({
    required this.type,
    required this.email,
    required this.amount,
    required this.authorizationCode,
  });

  String type;
  String email;
  int amount;
  String authorizationCode;

  factory PayWithSavedCardRequestEntity.fromJson(Map<String, dynamic> json) =>
      PayWithSavedCardRequestEntity(
        type: json["type"],
        email: json["email"],
        amount: json["amount"],
        authorizationCode: json["authorization_code"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "email": email,
        "amount": amount,
        "authorization_code": authorizationCode,
      };
}
