// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistEntity _$PlaylistEntityFromJson(Map<String, dynamic> json) =>
    PlaylistEntity(
      json['encodeId'] as String?,
      json['title'] as String?,
      json['sortDescription'] as String?,
      json['thumbnail'] as String?,
    );

Map<String, dynamic> _$PlaylistEntityToJson(PlaylistEntity instance) =>
    <String, dynamic>{
      'encodeId': instance.encodeId,
      'title': instance.title,
      'sortDescription': instance.sortDescription,
      'thumbnail': instance.thumbnail,
    };
