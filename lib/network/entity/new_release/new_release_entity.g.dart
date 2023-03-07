// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_release_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewReleaseEntity _$NewReleaseEntityFromJson(Map<String, dynamic> json) =>
    NewReleaseEntity(
      (json['all'] as List<dynamic>)
          .map((e) => SongChartEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['vPop'] as List<dynamic>)
          .map((e) => SongChartEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['others'] as List<dynamic>)
          .map((e) => SongChartEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewReleaseEntityToJson(NewReleaseEntity instance) =>
    <String, dynamic>{
      'all': instance.all,
      'vPop': instance.vPop,
      'others': instance.others,
    };
