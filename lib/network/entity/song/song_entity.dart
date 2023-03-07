import 'package:json_annotation/json_annotation.dart';

part 'song_entity.g.dart';

@JsonSerializable()
class SongEntity {
  @JsonKey(name: "128")
  final String? quality128;
  @JsonKey(name: "320")
  final String? quality320;

  String getHighestQuality(){
    return (quality320==null)?quality128!:quality320!;
  }

  SongEntity(this.quality128, this.quality320);

  factory SongEntity.fromJson(Map<String,dynamic> json) => _$SongEntityFromJson(json);

  Map<String,dynamic> toJson() => _$SongEntityToJson(this);
}