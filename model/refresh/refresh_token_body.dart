import 'package:json_annotation/json_annotation.dart';
part 'refresh_token_body.g.dart';

@JsonSerializable ()
class RefreshTokenBody {

  @JsonKey (name: 'refresh')
  String refreshToken;

  RefreshTokenBody ( this.refreshToken);

  factory RefreshTokenBody.fromJson (Map <String, dynamic> json) => _$RefreshTokenBodyFromJson(json);

  Map <String, dynamic> toJson () => _$RefreshTokenBodyToJson(this);

  @override
  String toString () {
    return 'RefreshTokenBody {refreshToken: $refreshToken}';
  }
}
