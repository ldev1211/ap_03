import 'package:json_annotation/json_annotation.dart';

part 'hot_artist_entity.g.dart';

@JsonSerializable()
class HotArtistEntity{

  final String? encodeId;
  final String? title;
  final String? sortDescription;
  final String? thumbnail;
  final int? totalFollow;

  HotArtistEntity(this.encodeId,this.title, this.sortDescription, this.thumbnail, this.totalFollow);

  factory HotArtistEntity.fromJson(Map<String,dynamic> json) => _$HotArtistEntityFromJson(json);

  Map<String,dynamic> toJson() => _$HotArtistEntityToJson(this);
}