import 'package:ap_03_luongquocdien/network/entity/banner/link_banner_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_banner.g.dart';

@JsonSerializable()
class ResponseBanner {
  final bool error;
  final String message;
  final List<LinkBannerEntity> data;

  ResponseBanner(this.error, this.message, this.data);

  factory ResponseBanner.fromJson(Map<String,dynamic> json) => _$ResponseBannerFromJson(json);

  Map<String,dynamic> toJson() => _$ResponseBannerToJson(this);
}