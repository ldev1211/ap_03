// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_new_release.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseNewRelease _$ResponseNewReleaseFromJson(Map<String, dynamic> json) =>
    ResponseNewRelease(
      json['error'] as bool,
      json['message'] as String,
      NewReleaseEntity.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseNewReleaseToJson(ResponseNewRelease instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data,
    };

ResponseNewReleaseChart _$ResponseNewReleaseChartFromJson(
        Map<String, dynamic> json) =>
    ResponseNewReleaseChart(
      json['error'] as bool,
      json['message'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => SongChartEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseNewReleaseChartToJson(
        ResponseNewReleaseChart instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data,
    };
