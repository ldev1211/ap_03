// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_100_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Top100Entity _$Top100EntityFromJson(Map<String, dynamic> json) => Top100Entity(
      json['title'] as String?,
      (json['items'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : PlaylistEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$Top100EntityToJson(Top100Entity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'items': instance.items,
    };
