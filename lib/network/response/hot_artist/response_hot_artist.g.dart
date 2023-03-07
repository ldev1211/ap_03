// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_hot_artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseHotArtist _$ResponseHotArtistFromJson(Map<String, dynamic> json) =>
    ResponseHotArtist(
      json['error'] as bool,
      json['message'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => HotArtistEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseHotArtistToJson(ResponseHotArtist instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data,
    };
