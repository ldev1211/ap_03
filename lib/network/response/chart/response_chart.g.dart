// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_chart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseChart _$ResponseChartFromJson(Map<String, dynamic> json) =>
    ResponseChart(
      json['error'] as bool,
      json['message'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => SongChartEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseChartToJson(ResponseChart instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data,
    };
