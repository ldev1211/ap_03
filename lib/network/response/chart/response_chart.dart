import 'package:ap_03_luongquocdien/network/entity/chart/song_chart_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_chart.g.dart';

@JsonSerializable()
class ResponseChart {
  final bool error;
  final String message;
  final List<SongChartEntity> data;

  ResponseChart(this.error, this.message, this.data);

  factory ResponseChart.fromJson(Map<String,dynamic> json) => _$ResponseChartFromJson(json);

  Map<String,dynamic> toJson() => _$ResponseChartToJson(this);
}