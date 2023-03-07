// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_top_100.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseTop100 _$ResponseTop100FromJson(Map<String, dynamic> json) =>
    ResponseTop100(
      json['error'] as bool,
      json['message'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => Top100Entity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseTop100ToJson(ResponseTop100 instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data,
    };
