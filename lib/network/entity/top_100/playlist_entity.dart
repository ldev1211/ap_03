import 'package:json_annotation/json_annotation.dart';

part 'playlist_entity.g.dart';

@JsonSerializable()
class PlaylistEntity{

  final String? encodeId;
  final String? title;
  final String? sortDescription;
  final String? thumbnail;

  PlaylistEntity(this.encodeId,this.title, this.sortDescription, this.thumbnail);

  factory PlaylistEntity.fromJson(Map<String,dynamic> json) => _$PlaylistEntityFromJson(json);

  Map<String,dynamic> toJson() => _$PlaylistEntityToJson(this);
}