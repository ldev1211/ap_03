import 'package:ap_03_luongquocdien/network/entity/top_100/playlist_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'top_100_entity.g.dart';

@JsonSerializable()
class Top100Entity{

  final String? title;
  final List<PlaylistEntity?>? items;

  Top100Entity(this.title, this.items);

  factory Top100Entity.fromJson(Map<String,dynamic> json) => _$Top100EntityFromJson(json);

  Map<String,dynamic> toJson() => _$Top100EntityToJson(this);
}