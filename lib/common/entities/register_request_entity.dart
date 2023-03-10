import 'dart:convert';

RegisterRequestEntity registerRequestEntityFromJson(String str) =>
    RegisterRequestEntity.fromJson(json.decode(str));

String registerRequestEntityToJson(RegisterRequestEntity data) =>
    json.encode(data.toJson());

class RegisterRequestEntity {
  RegisterRequestEntity({
    required this.name,
    required this.email,
    required this.password,
  });

  String name;
  String email;
  String password;

  factory RegisterRequestEntity.fromJson(Map<String, dynamic> json) =>
      RegisterRequestEntity(
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
      };
}
