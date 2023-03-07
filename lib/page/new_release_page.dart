import 'package:ap_03_luongquocdien/bloc/play_music/bloc.dart';
import 'package:ap_03_luongquocdien/bloc/play_music/event.dart';
import 'package:ap_03_luongquocdien/network/entity/chart/song_chart_entity.dart';
import 'package:flutter/material.dart';
import 'package:ap_03_luongquocdien/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '';

class NewReleasePage extends StatefulWidget{
  const NewReleasePage({super.key});

  @override
  State<NewReleasePage> createState() => _NewReleasePage();
}

class _NewReleasePage extends State<NewReleasePage> with AutomaticKeepAliveClientMixin<NewReleasePage>{

  List<SongChartEntity?> all = [];
  List<SongChartEntity?> vPop = [];
  List<SongChartEntity?> other = [];

  int indexType = 0;
  List<SongChartEntity> tmp = [];
  List<SongChartEntity> listSongChart = [];

  Future<void> getNewRelease() async {
    final response = await service.getNewRelease();
    setState(() {
      all = response.data.all;
      vPop = response.data.vPop;
      other = response.data.others;
      for(int i=0;i<all.length;++i){
        tmp.add(all[i]!);
      }
    });
  }

  Future<void> getNewReleaseChart() async {
    final response = await service.getNewReleaseChart();
    setState(() {
      listSongChart = response.data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewRelease();
    getNewReleaseChart();
  }
  void emitEvent(String id, String quality,String title,String artist,String linkThumb,double secondDuration){
    BlocProvider.of<PlayMusicBloc>(context).add(PlaySongEvent(id, quality,title,artist,linkThumb,Duration(seconds: secondDuration.toInt())));
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Mới phát hành",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 50)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            indexType = 0;
                            tmp.clear();
                            for(int i=0;i<all.length;++i){
                              tmp.add(all[i]!);
                            }
                          });
                        },
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(24)),
                              border: Border.all(color: (indexType==0)?Colors.red:Colors.grey),
                              color: (indexType==0)?Colors.red:Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Tất cả",
                                style: TextStyle(
                                    color: (indexType==0)?Colors.white:Colors.grey,
                                    fontSize: 15
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 12)),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            indexType = 1;
                            tmp.clear();
                            for(int i=0;i<vPop.length;++i){
                              tmp.add(vPop[i]!);
                            }
                          });
                        },
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(24)),
                              border: Border.all(color: (indexType==1)?Colors.red:Colors.grey),
                              color: (indexType==1)?Colors.red:Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Việt Nam",
                                style: TextStyle(
                                    color: (indexType==1)?Colors.white:Colors.grey,
                                    fontSize: 15
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 12)),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            indexType = 2;
                            tmp.clear();
                            for(int i=0;i<other.length;++i){
                              tmp.add(other[i]!);
                            }
                          });
                        },
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(24)),
                              border: Border.all(color: (indexType==2)?Colors.red:Colors.grey),
                              color: (indexType==2)?Colors.red:Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Khác",
                                style: TextStyle(
                                    color: (indexType==2)?Colors.white:Colors.grey,
                                    fontSize: 15
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 40)),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: tmp.length,
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap:() async {
                            String id = tmp[index].encodeId!;
                            String linkThumb = tmp[index].thumbnailM!;
                            final response = await service.getSong(id);
                            emitEvent(id,(response.data.quality320=="VIP")?"320":"128",tmp[index].title!,tmp[index].artistsNames!,linkThumb,tmp[index].duration!);
                          },
                          child: Container(
                            height: 120,
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                  child: Image(image: NetworkImage(tmp[index].thumbnailM!)),
                                ),
                                const Padding(padding: EdgeInsets.only(right: 8)),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tmp[index].title!,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      tmp[index].artistsNames!,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Xếp hạng mới phát hành",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 12)),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: listSongChart.length,
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap:() async {
                            String id = listSongChart[index].encodeId!;
                            String linkThumb = listSongChart[index].thumbnailM!;
                            final response = await service.getSong(id);
                            emitEvent(id,(response.data.quality320=="VIP")?"320":"128",listSongChart[index].title!,listSongChart[index].artistsNames!,linkThumb,listSongChart[index].duration!);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${index+1}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.only(right: 8)),
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                  child: Image(image: NetworkImage(listSongChart[index].thumbnailM!),width: 100,height: 100,),
                                ),
                                const Padding(padding: EdgeInsets.only(right: 8)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      listSongChart[index].title!,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.only(top: 12)),
                                    Text(
                                      listSongChart[index].artistsNames!,
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.5,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      )
    );
  }
  @override
  bool get wantKeepAlive => true;
}