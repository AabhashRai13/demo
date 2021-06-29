// To parse this JSON data, do
//
//     final registrationResponse = registrationResponseFromJson(jsonString);

import 'dart:convert';

RegistrationResponse registrationResponseFromJson(String str) => RegistrationResponse.fromJson(json.decode(str));

String registrationResponseToJson(RegistrationResponse data) => json.encode(data.toJson());

class RegistrationResponse {
  RegistrationResponse({
    this.username,
    this.email,
    this.password,
    this.password2,
  });

  String username;
  String email;
  String password;
  String password2;

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) => RegistrationResponse(
    username: json["username"],
    email: json["email"],
    password: json["password"],
    password2: json["password2"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "password": password,
    "password2": password2,
  };
}
