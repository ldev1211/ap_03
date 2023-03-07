import 'package:ap_03_luongquocdien/main.dart';
import 'package:ap_03_luongquocdien/network/response/banner/response_banner.dart';
import 'package:ap_03_luongquocdien/network/response/chart/response_chart.dart';
import 'package:ap_03_luongquocdien/network/response/hot_artist/response_hot_artist.dart';
import 'package:ap_03_luongquocdien/network/response/lyric/response_lyric.dart';
import 'package:ap_03_luongquocdien/network/response/song/response_song.dart';
import 'package:ap_03_luongquocdien/network/response/top100/response_top_100.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

import '../../response/new_release/response_new_release.dart';

part 'music_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class MusicService {
  factory MusicService(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(
        receiveTimeout: const Duration(seconds: 10),
        connectTimeout: const Duration(seconds: 10),
        contentType: 'application/json',
        headers: {
          'authorization':'Bearer ${shared.getString("accessToken")}',
          'Content-Type':'application/json'
        }
    );
    return _MusicService(dio,baseUrl:baseUrl);
  }

  @GET("/get_banner")
  Future<ResponseBanner> getBanner();

  @GET("/get_top_100")
  Future<ResponseTop100> getTop100();

  @GET("/get_chart_home")
  Future<ResponseChart> getChart();

  @GET("/get_hot_artist")
  Future<ResponseHotArtist> getHotArtist();

  @GET("/get_new_release")
  Future<ResponseNewRelease> getNewRelease();

  @GET("/get_new_release_chart")
  Future<ResponseNewReleaseChart> getNewReleaseChart();

  @GET("/get_song")
  Future<ResponseSong> getSong(@Query("id") String id);

  @GET("/search")
  Future<ResponseChart> search(@Query("string_search") String stringSearch);

  @GET("/get_lyric")
  Future<ResponseLyric> getLyric(@Query("id") String id);

}