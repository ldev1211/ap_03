import 'package:ap_03_luongquocdien/network/entity/chart/song_chart_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_release_entity.g.dart';

@JsonSerializable()
class NewReleaseEntity{

  final List<SongChartEntity> all;
  final List<SongChartEntity> vPop;
  final List<SongChartEntity> others;


  NewReleaseEntity(this.all, this.vPop, this.others);

  factory NewReleaseEntity.fromJson(Map<String,dynamic> json) => _$NewReleaseEntityFromJson(json);

  Map<String,dynamic> toJson() => _$NewReleaseEntityToJson(this);
}