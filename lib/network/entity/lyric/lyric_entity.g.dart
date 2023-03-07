// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyric_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sentence _$SentenceFromJson(Map<String, dynamic> json) => Sentence(
      (json['words'] as List<dynamic>)
          .map((e) => Word.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SentenceToJson(Sentence instance) => <String, dynamic>{
      'words': instance.words,
    };

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      json['startTime'] as int,
      json['endTime'] as int,
      json['data'] as String,
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'data': instance.data,
    };
