import 'dart:convert';

UserAuthResponseEntity userAuthResponseEntityFromJson(String str) =>
    UserAuthResponseEntity.fromJson(json.decode(str));

String userAuthResponseEntityToJson(UserAuthResponseEntity data) =>
    json.encode(data.toJson());

class UserAuthResponseEntity {
  UserAuthResponseEntity({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory UserAuthResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserAuthResponseEntity(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.token,
    this.user,
  });

  String? token;
  User? user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user!.toJson(),
      };
}

class User {
  User({
    this.name,
    this.email,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? name;
  String? email;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
      };
}
