import 'package:ap_03_luongquocdien/network/entity/user/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_login.g.dart';

@JsonSerializable()
class ResponseLogin {
  final bool error;
  final String message;
  final UserEntity? data;

  ResponseLogin(this.error, this.message, this.data);

  factory ResponseLogin.fromJson(Map<String,dynamic> json) => _$ResponseLoginFromJson(json);

  Map<String,dynamic> toJson() => _$ResponseLoginToJson(this);
}