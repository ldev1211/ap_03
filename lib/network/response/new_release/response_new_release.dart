import 'package:ap_03_luongquocdien/network/entity/chart/song_chart_entity.dart';
import 'package:ap_03_luongquocdien/network/entity/new_release/new_release_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_new_release.g.dart';

@JsonSerializable()
class ResponseNewRelease {
  final bool error;
  final String message;
  final NewReleaseEntity data;

  ResponseNewRelease(this.error, this.message, this.data);

  factory ResponseNewRelease.fromJson(Map<String,dynamic> json) => _$ResponseNewReleaseFromJson(json);

  Map<String,dynamic> toJson() => _$ResponseNewReleaseToJson(this);
}

@JsonSerializable()
class ResponseNewReleaseChart{
  final bool error;
  final String message;
  final List<SongChartEntity> data;

  ResponseNewReleaseChart(this.error, this.message, this.data);

  factory ResponseNewReleaseChart.fromJson(Map<String,dynamic> json) => _$ResponseNewReleaseChartFromJson(json);

  Map<String,dynamic> toJson() => _$ResponseNewReleaseChartToJson(this);
}