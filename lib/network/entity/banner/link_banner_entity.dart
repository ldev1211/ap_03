import 'package:json_annotation/json_annotation.dart';

part 'link_banner_entity.g.dart';

@JsonSerializable()
class LinkBannerEntity{
  final String? link;
  final String? banner;

  LinkBannerEntity(this.link, this.banner);

  factory LinkBannerEntity.fromJson(Map<String,dynamic> json) => _$LinkBannerEntityFromJson(json);

  Map<String,dynamic> toJson() => _$LinkBannerEntityToJson(this);
}