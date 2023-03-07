import 'package:json_annotation/json_annotation.dart';

part 'response_template.g.dart';

@JsonSerializable()
class ResponseTemplate {
  final bool error;
  final String message;

  ResponseTemplate(this.error, this.message);

  factory ResponseTemplate.fromJson(Map<String,dynamic> json) => _$ResponseTemplateFromJson(json);

  Map<String,dynamic> toJson() => _$ResponseTemplateToJson(this);
}