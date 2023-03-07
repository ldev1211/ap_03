// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseSong _$ResponseSongFromJson(Map<String, dynamic> json) => ResponseSong(
      json['error'] as bool,
      json['message'] as String,
      SongEntity.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseSongToJson(ResponseSong instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data,
    };
