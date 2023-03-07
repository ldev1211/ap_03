import 'package:ap_03_luongquocdien/network/entity/top_100/top_100_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_top_100.g.dart';

@JsonSerializable()
class ResponseTop100 {
  final bool error;
  final String message;
  final List<Top100Entity> data;

  ResponseTop100(this.error, this.message, this.data);

  factory ResponseTop100.fromJson(Map<String,dynamic> json) => _$ResponseTop100FromJson(json);

  Map<String,dynamic> toJson() => _$ResponseTop100ToJson(this);
}