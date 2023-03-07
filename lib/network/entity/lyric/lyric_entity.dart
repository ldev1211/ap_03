import 'package:json_annotation/json_annotation.dart';

part 'lyric_entity.g.dart';

@JsonSerializable()
class Sentence {
  final List<Word> words;
  Sentence(this.words);

  factory Sentence.fromJson(Map<String,dynamic> json) => _$SentenceFromJson(json);

  Map<String,dynamic> toJson() => _$SentenceToJson(this);
}

@JsonSerializable()
class Word {
  final int startTime;
  final int endTime;
  final String data;

  Word(this.startTime, this.endTime, this.data);

  factory Word.fromJson(Map<String,dynamic> json) => _$WordFromJson(json);

  Map<String,dynamic> toJson() => _$WordToJson(this);
}