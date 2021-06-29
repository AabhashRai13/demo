// To parse this JSON data, do
//
//     final refreshToken = refreshTokenFromJson(jsonString);

import 'dart:convert';

RefreshToken refreshTokenFromJson(String str) => RefreshToken.fromJson(json.decode(str));

String refreshTokenToJson(RefreshToken data) => json.encode(data.toJson());

class RefreshToken {
  RefreshToken({
    this.access,
    this.lifetime,
  });

  String access;
  int lifetime;
  String error;

  factory RefreshToken.fromJson(Map<String, dynamic> json) => RefreshToken(
    access: json["access"],
    lifetime: json["lifetime"],
  );

  Map<String, dynamic> toJson() => {
    "access": access,
    "lifetime": lifetime,
  };
  RefreshToken.withError(this.error);
}
