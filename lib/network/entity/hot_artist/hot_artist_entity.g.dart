// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_artist_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotArtistEntity _$HotArtistEntityFromJson(Map<String, dynamic> json) =>
    HotArtistEntity(
      json['encodeId'] as String?,
      json['title'] as String?,
      json['sortDescription'] as String?,
      json['thumbnail'] as String?,
      json['totalFollow'] as int?,
    );

Map<String, dynamic> _$HotArtistEntityToJson(HotArtistEntity instance) =>
    <String, dynamic>{
      'encodeId': instance.encodeId,
      'title': instance.title,
      'sortDescription': instance.sortDescription,
      'thumbnail': instance.thumbnail,
      'totalFollow': instance.totalFollow,
    };
