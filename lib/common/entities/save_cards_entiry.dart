import 'dart:convert';

SavedCardsEntity savedCardsEntityFromJson(String str) =>
    SavedCardsEntity.fromJson(json.decode(str));

String savedCardsEntityToJson(SavedCardsEntity data) =>
    json.encode(data.toJson());

class SavedCardsEntity {
  SavedCardsEntity({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<SavedCard>? data;

  factory SavedCardsEntity.fromJson(Map<String, dynamic> json) =>
      SavedCardsEntity(
        status: json["status"],
        message: json["message"],
        data: List<SavedCard>.from(
            json["data"].map((x) => SavedCard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SavedCard {
  SavedCard({
    this.id,
    this.userId,
    this.authorizationCode,
    this.bin,
    this.last4,
    this.expMonth,
    this.expYear,
    this.channel,
    this.cardType,
    this.bank,
    this.countryCode,
    this.brand,
    this.reusable,
    this.signature,
    this.accountName,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? authorizationCode;
  String? bin;
  String? last4;
  String? expMonth;
  String? expYear;
  String? channel;
  String? cardType;
  String? bank;
  String? countryCode;
  String? brand;
  String? reusable;
  String? signature;
  dynamic accountName;
  dynamic createdAt;
  dynamic updatedAt;

  factory SavedCard.fromJson(Map<String, dynamic> json) => SavedCard(
        id: json["id"],
        userId: json["user_id"],
        authorizationCode: json["authorization_code"],
        bin: json["bin"],
        last4: json["last4"],
        expMonth: json["exp_month"],
        expYear: json["exp_year"],
        channel: json["channel"],
        cardType: json["card_type"],
        bank: json["bank"],
        countryCode: json["country_code"],
        brand: json["brand"],
        reusable: json["reusable"],
        signature: json["signature"],
        accountName: json["account_name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "authorization_code": authorizationCode,
        "bin": bin,
        "last4": last4,
        "exp_month": expMonth,
        "exp_year": expYear,
        "channel": channel,
        "card_type": cardType,
        "bank": bank,
        "country_code": countryCode,
        "brand": brand,
        "reusable": reusable,
        "signature": signature,
        "account_name": accountName,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
