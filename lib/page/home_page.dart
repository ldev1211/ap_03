import 'package:ap_03_luongquocdien/bloc/play_music/bloc.dart';
import 'package:ap_03_luongquocdien/bloc/play_music/event.dart';
import 'package:ap_03_luongquocdien/network/entity/banner/link_banner_entity.dart';
import 'package:ap_03_luongquocdien/network/entity/chart/song_chart_entity.dart';
import 'package:ap_03_luongquocdien/network/entity/top_100/top_100_entity.dart';
import 'package:ap_03_luongquocdien/main.dart';
import 'package:ap_03_luongquocdien/page/main_page.dart';
import 'package:ap_03_luongquocdien/page/search_result_dialog.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../network/entity/hot_artist/hot_artist_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  final _textSearchController = TextEditingController();
  final _carouselController = CarouselController();

  List<LinkBannerEntity?> listLinkBanner = [];

  List<Top100Entity?> listTop100 = [];
  List<SongChartEntity?> listSongChart = [];
  List<HotArtistEntity?> listHotArtist = [];
  Future<void> getTop100() async {
    final response = await service.getTop100();
    setState(() {
      listTop100 = response.data;
    });
  }

  void emitEvent(String id, String quality, String title, String artist,
      String linkThumb, double secondDuration) {
    MainPageProvider.musicBloc.add(PlaySongEvent(id, quality, title, artist,
        linkThumb, Duration(seconds: secondDuration.toInt())));
  }

  Future<void> getHotArtist() async {
    final response = await service.getHotArtist();
    setState(() {
      listHotArtist = response.data;
    });
  }

  Future<void> getBanner() async {
    final response = await service.getBanner();
    setState(() {
      listLinkBanner = response.data;
    });
  }

  Future<void> getChart() async {
    final response = await service.getChart();
    setState(() {
      listSongChart = response.data;
    });
  }

  late Dialog errorDialog;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: SizedBox(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Cool',
                style: TextStyle(color: Colors.red),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Awesome',
                style: TextStyle(color: Colors.red),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 50.0)),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Got It!',
                  style: TextStyle(color: Colors.purple, fontSize: 18.0),
                ))
          ],
        ),
      ),
    );
    getBanner();
    getTop100();
    getChart();
    getHotArtist();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 24)),
                      Container(
                        height: 50,
                        width: 1200,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24))),
                        child: TextField(
                          onSubmitted: (stringSearch) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    SearchResultDialog(
                                        _textSearchController.text, "listen"));
                          },
                          textInputAction: TextInputAction.go,
                          controller: _textSearchController,
                          decoration: const InputDecoration(
                              hintText: "Tìm kiếm",
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.search)),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 24)),
                      InkWell(
                        onTap: () {},
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: CarouselSlider(
                            items: listLinkBanner
                                .map((e) => Image(
                                      image: NetworkImage(e!.banner!),
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    ))
                                .toList(),
                            carouselController: _carouselController,
                            options: CarouselOptions(
                                scrollPhysics: const BouncingScrollPhysics(),
                                autoPlay: true,
                                aspectRatio: 2,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  // setState(() {
                                  //   currIndex = index;
                                  // });
                                }),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 24)),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "Top 100 bài hát",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            Padding(padding: EdgeInsets.only(right: 4)),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 12)),
                      SizedBox(
                        height: 260,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listTop100.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 24),
                                width: 165,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image(
                                          image: NetworkImage(listTop100[index]!
                                              .items![0]!
                                              .thumbnail!)),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(top: 4)),
                                    Flexible(
                                      child: Text(
                                        listTop100[index]!.items![0]!.title!,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 12)),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                "Nghệ sĩ đang \"Hot\"",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(padding: EdgeInsets.only(right: 4)),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                              )
                            ]),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 12)),
                      SizedBox(
                        height: 500,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listHotArtist.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 24),
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image(
                                          image: NetworkImage(
                                              listHotArtist[index]!
                                                  .thumbnail!)),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(top: 4)),
                                    Flexible(
                                      child: Text(
                                        listHotArtist[index]!.title!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        listHotArtist[index]!.sortDescription!,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 24)),
              Container(
                  width: 300,
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(color: Colors.red, width: 2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 24)),
                      const Text(
                        "Top 100 bài hát của tuần",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 12)),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: listSongChart.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  String id = listSongChart[index]!.encodeId!;
                                  String linkThumb =
                                      listSongChart[index]!.thumbnailM!;
                                  final response = await service.getSong(id);
                                  emitEvent(
                                      id,
                                      (response.data.quality320 == "VIP")
                                          ? "320"
                                          : "128",
                                      listSongChart[index]!.title!,
                                      listSongChart[index]!.artistsNames!,
                                      linkThumb,
                                      listSongChart[index]!.duration!);
                                },
                                child: Container(
                                  height: 100,
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.only(top: 24)),
                                      Text(
                                        "${index + 1}",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(right: 8)),
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        child: Image(
                                            image: NetworkImage(
                                                listSongChart[index]!
                                                    .thumbnailM!)),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(right: 8)),
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${listSongChart[index]!.title}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              "${listSongChart[index]!.artistsNames}",
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
