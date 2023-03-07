import 'package:json_annotation/json_annotation.dart';

part 'song_chart_entity.g.dart';

@JsonSerializable()
class SongChartEntity{

  final String? encodeId;
  final String? title;
  final String? artistsNames;
  final String? thumbnailM;
  final double? releaseDate;
  final double? duration;

  SongChartEntity(this.encodeId, this.title, this.artistsNames, this.thumbnailM, this.releaseDate, this.duration);

  factory SongChartEntity.fromJson(Map<String,dynamic> json) => _$SongChartEntityFromJson(json);

  Map<String,dynamic> toJson() => _$SongChartEntityToJson(this);
}