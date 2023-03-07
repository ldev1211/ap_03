// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_chart_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongChartEntity _$SongChartEntityFromJson(Map<String, dynamic> json) =>
    SongChartEntity(
      json['encodeId'] as String?,
      json['title'] as String?,
      json['artistsNames'] as String?,
      json['thumbnailM'] as String?,
      (json['releaseDate'] as num?)?.toDouble(),
      (json['duration'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SongChartEntityToJson(SongChartEntity instance) =>
    <String, dynamic>{
      'encodeId': instance.encodeId,
      'title': instance.title,
      'artistsNames': instance.artistsNames,
      'thumbnailM': instance.thumbnailM,
      'releaseDate': instance.releaseDate,
      'duration': instance.duration,
    };
