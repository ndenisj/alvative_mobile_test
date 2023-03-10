import 'dart:convert';

LoginRequestEntity loginRequestEntityFromJson(String str) =>
    LoginRequestEntity.fromJson(json.decode(str));

String loginRequestEntityToJson(LoginRequestEntity data) =>
    json.encode(data.toJson());

class LoginRequestEntity {
  LoginRequestEntity({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory LoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      LoginRequestEntity(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
