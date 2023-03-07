// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseTemplate _$ResponseTemplateFromJson(Map<String, dynamic> json) =>
    ResponseTemplate(
      json['error'] as bool,
      json['message'] as String,
    );

Map<String, dynamic> _$ResponseTemplateToJson(ResponseTemplate instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
    };
