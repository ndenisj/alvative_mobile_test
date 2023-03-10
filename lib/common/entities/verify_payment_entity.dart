import 'dart:convert';

VerifyPaymentRequestEntity verifyPaymentRequestEntityFromJson(String str) =>
    VerifyPaymentRequestEntity.fromJson(json.decode(str));

String verifyPaymentRequestEntityToJson(VerifyPaymentRequestEntity data) =>
    json.encode(data.toJson());

class VerifyPaymentRequestEntity {
  VerifyPaymentRequestEntity({
    required this.type,
    required this.ref,
    required this.userId,
  });

  String type;
  String ref;
  int userId;

  factory VerifyPaymentRequestEntity.fromJson(Map<String, dynamic> json) =>
      VerifyPaymentRequestEntity(
        type: json["type"],
        ref: json["ref"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "ref": ref,
        "user_id": userId,
      };
}
