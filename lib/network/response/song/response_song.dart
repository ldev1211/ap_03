import 'package:ap_03_luongquocdien/network/entity/song/song_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_song.g.dart';

@JsonSerializable()
class ResponseSong {
  final bool error;
  final String message;
  final SongEntity data;

  ResponseSong(this.error, this.message, this.data);

  factory ResponseSong.fromJson(Map<String,dynamic> json) => _$ResponseSongFromJson(json);

  Map<String,dynamic> toJson() => _$ResponseSongToJson(this);
}