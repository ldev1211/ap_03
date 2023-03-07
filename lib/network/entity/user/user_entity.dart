import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  final String fullName;
  final String accessToken;

  UserEntity(this.fullName, this.accessToken);

  factory UserEntity.fromJson(Map<String,dynamic> json) => _$UserEntityFromJson(json);

  Map<String,dynamic> toJson() => _$UserEntityToJson(this);
}