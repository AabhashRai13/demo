import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: 'refresh_token')
  String refreshToken;
  @JsonKey(name: 'access_token')
  String accessToken;

  String error;

  Token(
    this.refreshToken,
    this.accessToken,
  );

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Token.withError(this.error);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  @override
  String toString() {
    return 'Token {  refreshToken: $refreshToken, accessToken: $accessToken}';
  }
}
