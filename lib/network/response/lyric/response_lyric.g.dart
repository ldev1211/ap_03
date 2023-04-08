// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_lyric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseLyric _$ResponseLyricFromJson(Map<String, dynamic> json) =>
    ResponseLyric(
      json['error'] as bool,
      json['message'] as String,
      json['data'] as String?,
    );

Map<String, dynamic> _$ResponseLyricToJson(ResponseLyric instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data,
    };
