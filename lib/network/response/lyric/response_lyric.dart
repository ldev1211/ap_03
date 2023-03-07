import 'package:ap_03_luongquocdien/network/entity/lyric/lyric_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_lyric.g.dart';

@JsonSerializable()
class ResponseLyric{
  final bool error;
  final String message;
  final String data;

  ResponseLyric(this.error, this.message, this.data);

  factory ResponseLyric.fromJson(Map<String,dynamic> json) => _$ResponseLyricFromJson(json);

  Map<String,dynamic> toJson() => _$ResponseLyricToJson(this);
}