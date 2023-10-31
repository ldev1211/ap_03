import 'package:ap_03_luongquocdien/bloc/play_music/bloc.dart';
import 'package:ap_03_luongquocdien/bloc/play_music/event.dart';
import 'package:ap_03_luongquocdien/network/entity/chart/song_chart_entity.dart';
import 'package:ap_03_luongquocdien/network/route/music/music_service.dart';
import 'package:ap_03_luongquocdien/page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultDialog extends StatefulWidget {
  final String textSearch;
  final String action;

  const SearchResultDialog(this.textSearch, this.action, {Key? key})
      : super(key: key);

  @override
  State<SearchResultDialog> createState() => _SearchResultDialog();
}

class _SearchResultDialog extends State<SearchResultDialog> {
  List<SongChartEntity> songs = [];

  late MusicService service;

  Future<void> search() async {
    final response = await service.search(widget.textSearch);
    setState(() {
      songs = response.data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service = MusicService(dio.Dio());
    search();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: SizedBox(
        width: 1100.0,
        height: 900.0,
        child: Padding(
          padding: const EdgeInsets.all(36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Kết quả tìm kiếm:",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
              const Padding(padding: EdgeInsets.only(top: 24)),
              Visibility(
                visible: songs.isEmpty,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [CircularProgressIndicator()],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      String id = songs[index].encodeId!;
                      final response = await service.getSong(id);
                      MainPageProvider.musicBloc.add((widget.action == "listen")
                          ? PlaySongEvent(
                              id,
                              (response.data.quality320 == "VIP")
                                  ? "320"
                                  : "128",
                              songs[index].title!,
                              songs[index].artistsNames!,
                              songs[index].thumbnailM!,
                              Duration(seconds: songs[index].duration!.toInt()))
                          : KaraokeEvent(
                              id,
                              (response.data.quality320 == "VIP")
                                  ? "320"
                                  : "128",
                              songs[index].title!,
                              songs[index].artistsNames!,
                              songs[index].thumbnailM!,
                              Duration(
                                  seconds: songs[index].duration!.toInt())));
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Image(
                                image: NetworkImage(songs[index].thumbnailM!)),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 8)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                songs[index].title!,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 12)),
                              Text(
                                songs[index].artistsNames!,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
