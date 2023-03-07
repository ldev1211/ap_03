// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBanner _$ResponseBannerFromJson(Map<String, dynamic> json) =>
    ResponseBanner(
      json['error'] as bool,
      json['message'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => LinkBannerEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseBannerToJson(ResponseBanner instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data,
    };
