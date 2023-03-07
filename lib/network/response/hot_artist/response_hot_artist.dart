import 'package:ap_03_luongquocdien/network/entity/hot_artist/hot_artist_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_hot_artist.g.dart';

@JsonSerializable()
class ResponseHotArtist {
  final bool error;
  final String message;
  final List<HotArtistEntity> data;

  ResponseHotArtist(this.error, this.message, this.data);

  factory ResponseHotArtist.fromJson(Map<String,dynamic> json) => _$ResponseHotArtistFromJson(json);

  Map<String,dynamic> toJson() => _$ResponseHotArtistToJson(this);
}