import 'dart:convert';
import 'dart:io';

import 'package:ap_03_luongquocdien/bloc/play_music/bloc.dart';
import 'package:ap_03_luongquocdien/bloc/play_music/event.dart';
import 'package:ap_03_luongquocdien/bloc/play_music/state.dart';
import 'package:ap_03_luongquocdien/main.dart';
import 'package:ap_03_luongquocdien/page/home_page.dart';
import 'package:ap_03_luongquocdien/page/karaoke_page.dart';
import 'package:ap_03_luongquocdien/page/new_release_page.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageProvider extends StatelessWidget {
  const MainPageProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayMusicBloc(PlayMusicState()),
      child: const MainPage(),
    );
  }
}


class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {

  final pageController = PageController(initialPage: 0);
  int indexPage = 0;
  final _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PlayMusicBloc>(context).add(InitEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        body: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    width: 250,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Xin chào!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "${shared.getString("fullName")}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 12)),
                          const Divider(color: Colors.white,height: 1,),
                          const Padding(padding: EdgeInsets.only(top: 30)),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                indexPage=0;
                                pageController.animateToPage(indexPage, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: (indexPage==0)?Colors.red[800]:Colors.redAccent,
                                  borderRadius: const BorderRadius.all(Radius.circular(12))
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.home_filled, color: Colors.white,),
                                  Padding(padding: EdgeInsets.only(right: 8)),
                                  Text(
                                    "Trang chủ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 8)),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                indexPage=1;
                                pageController.animateToPage(indexPage, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: (indexPage==1) ? Colors.red[800]: Colors.redAccent,
                                  borderRadius: const BorderRadius.all(Radius.circular(12))
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.fiber_new_rounded, color: Colors.white,),
                                  Padding(padding: EdgeInsets.only(right: 8)),
                                  Text(
                                    "Mới phát hành",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 8)),
                          GestureDetector(
                            onTap: (){
                                setState(() {
                                  indexPage=2;
                                  pageController.animateToPage(indexPage, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                                });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: (indexPage==2) ? Colors.red[800] : Colors.redAccent,
                                  borderRadius: const BorderRadius.all(Radius.circular(12))
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.mic, color: Colors.white,),
                                  Padding(padding: EdgeInsets.only(right: 8)),
                                  Text(
                                    "Hát cùng ca sĩ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            "UI/UX Designing and Programing by: Lương Quốc Diễn (LDev)",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 12)),
                          const Text(
                            "Audio source: Zing mp3",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap:(){
                              shared.setString("fullName", "");
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyApp()));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Icon(Icons.logout,color: Colors.white,),
                                Padding(padding: EdgeInsets.only(right: 8)),
                                Text(
                                  "Đăng xuất",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                ),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    controller: pageController,
                    children: const [
                      HomePage(),
                      NewReleasePage(),
                      KaraokePage()
                    ],
                  ),
                )
              ],
            ),
            BlocListener<PlayMusicBloc,PlayMusicState>(
              listenWhen: (prev,curr){
                return curr is EndKaraokeState || curr is KaraokePointingState;
              },
              child: Container(),
              listener: (context,state){
                if(state is EndKaraokeState) {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('KẾT QUẢ:'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Text('Điểm số: ${state.point}'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK',style: TextStyle(color: Colors.orange),),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      }
                  );
                } else if (state is KaraokePointingState){
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Dialog(
                          backgroundColor: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator()
                            ],
                          )
                      );
                    },
                  );
                }
              },
            ),
            BlocBuilder<PlayMusicBloc,PlayMusicState>(
              buildWhen: (previous, current) {
                return current is PlaySongState;
              },
                builder: (context,state){
                  if(state is PlaySongState) {
                    return Positioned(
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        height: 90,
                        width: 1370,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red,width: 0.3),
                          color: Colors.white,
                        ),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //TODO: Button play
                              BlocBuilder<PlayMusicBloc,PlayMusicState>(
                                  buildWhen: (prev,curr){
                                    return curr is PlaySongState || curr is PauseSongState || curr is ResumeSongState;
                                  },
                                  builder: (context,state){
                                    return GestureDetector(
                                        onTap: (){
                                          BlocProvider.of<PlayMusicBloc>(context).add((state is PlaySongState || state is ResumeSongState)?PauseSongEvent():ResumeSongEvent());
                                        },
                                        child: Icon((state is PlaySongState || state is ResumeSongState)?Icons.pause_circle:Icons.play_circle_fill,size: 40,)
                                    );
                                  }
                              ),
                              const Padding(padding: EdgeInsets.only(right: 8)),
                              //TODO: Image thumb music
                              BlocBuilder<PlayMusicBloc,PlayMusicState>(
                                  buildWhen: (prev,curr){
                                    return curr is PlaySongState;
                                  },
                                  builder: (context,state){
                                    if(state is PlaySongState){
                                      return SizedBox(
                                        width: 300,
                                        child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                                child: Image(image: NetworkImage((state).linkThumb)),
                                              ),
                                              const Padding(padding: EdgeInsets.only(right: 12)),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  const Padding(padding: EdgeInsets.only(top: 4)),
                                                  Flexible(
                                                    child: Text(
                                                      state.title,
                                                      overflow: TextOverflow.clip,
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Flexible(
                                                    child: Text(
                                                      state.artist,
                                                      style: const TextStyle(
                                                          fontSize: 14
                                                      ),
                                                    ),
                                                  ),
                                                  const Padding(padding: EdgeInsets.only(top: 4)),
                                                ],
                                              ),
                                            ]
                                        ),
                                      );
                                    } else {
                                      return Row(
                                        children: [
                                          const Padding(padding: EdgeInsets.only(right: 12)),
                                          Image.asset("images/logo_ptit.png")
                                        ],
                                      );
                                    }
                                  }
                              ),
                              const Padding(padding: EdgeInsets.only(right: 4)),
                              BlocBuilder<PlayMusicBloc,PlayMusicState>(
                                  buildWhen: (prev,curr){
                                    return curr is SeekState || curr is PlaySongState || curr is AudioPositionChangeState;
                                  },
                                  builder: (context,state){
                                    if(state is PlaySongState){
                                      return Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                                "00:00"
                                            ),
                                            SizedBox(
                                              width: 500,
                                              height: 10,
                                              child: Slider(
                                                  max: state.total.inSeconds.toDouble(),
                                                  value: 0,
                                                  onChanged: (val) {
                                                    BlocProvider.of<PlayMusicBloc>(context).add(SeekEvent(Duration(seconds: val.toInt())));
                                                  }
                                              ),
                                            ),
                                            Text(
                                                "${state.total.inMinutes.toInt()}:${state.total.inSeconds.toInt()%60}"
                                            )
                                          ]
                                      );
                                    } else if(state is SeekState){
                                      return Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                                "${state.newDuration.inMinutes}:${state.newDuration.inSeconds%60}"
                                            ),
                                            SizedBox(
                                              width: 500,
                                              height: 10,
                                              child: Slider(
                                                  max: state.total.inSeconds.toDouble(),
                                                  value: state.newDuration.inSeconds.toDouble(),
                                                  onChanged: (val) {
                                                    BlocProvider.of<PlayMusicBloc>(context).add(SeekEvent(Duration(seconds: val.toInt())));
                                                  }
                                              ),
                                            ),
                                            Text(
                                                "${state.total.inMinutes.toInt()}:${state.total.inSeconds.toInt()%60}"
                                            )
                                          ]
                                      );
                                    } else if(state is AudioPositionChangeState){
                                      return Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                                "${state.currPosition.inMinutes}:${state.currPosition.inSeconds%60}"
                                            ),
                                            SizedBox(
                                              width: 500,
                                              height: 10,
                                              child: Slider(
                                                  min: 0,
                                                  max: state.total.inSeconds.toDouble(),
                                                  value: state.currPosition.inSeconds.toDouble(),
                                                  onChanged: (val) {
                                                    BlocProvider.of<PlayMusicBloc>(context).add(SeekEvent(Duration(seconds: val.toInt())));
                                                  }
                                              ),
                                            ),
                                            Text(
                                                "${state.total.inMinutes.toInt()}:${state.total.inSeconds.toInt()%60}"
                                            )
                                          ]
                                      );
                                    } else {
                                      return SizedBox(
                                        height:20,
                                        child: Slider(
                                            min: 0,
                                            max: 0,
                                            value: 0,
                                            onChanged: (val) {
                                              // BlocProvider.of<PlayMusicBloc>(context).add(SeekEvent(Duration(seconds: val.toInt())));
                                            }
                                        ),
                                      );
                                    }
                                  }
                              ),
                              const Padding(padding: EdgeInsets.only(right: 12)),
                              SizedBox(
                                width: 400,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: const BorderRadius.all(Radius.circular(12))
                                      ),
                                      child: TextField(
                                        onSubmitted: (stringSearch){
                                          BlocProvider.of<PlayMusicBloc>(context).add(ChangeSpeedEvent(double.parse(_controller.text)));
                                        },
                                        textInputAction: TextInputAction.go,
                                        controller:_controller,
                                        decoration: const InputDecoration.collapsed(hintText: "Tốc độ"),
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.only(right: 12)),
                                    const Icon(Icons.volume_up),
                                    BlocBuilder<PlayMusicBloc,PlayMusicState>(
                                        buildWhen: (prev,curr){
                                          return curr is ChangeVolumeState;
                                        },
                                        builder: (context,state){
                                          if(state is ChangeVolumeState){
                                            return Slider(
                                                max: 1,
                                                value: state.volume,
                                                onChanged: (val) {
                                                  BlocProvider.of<PlayMusicBloc>(context).add(ChangeVolumeEvent(val));
                                                }
                                            );
                                          } else {
                                            return Slider(
                                                max: 1,
                                                value: 1,
                                                onChanged: (val) {
                                                  BlocProvider.of<PlayMusicBloc>(context).add(ChangeVolumeEvent(val));
                                                }
                                            );
                                          }
                                        }
                                    ),
                                    BlocBuilder<PlayMusicBloc,PlayMusicState>(
                                        buildWhen: (prev,curr){
                                          return curr is DownloadSongState;
                                        },
                                        builder: (context,state){
                                          if(state is DownloadSongState) {
                                            return InkWell(
                                              onTap: (){
                                                BlocProvider.of<PlayMusicBloc>(context).add(DownloadSongEvent());
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(12),
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                                ),
                                                child: (!state.isDownloadedFinish)?const CircularProgressIndicator():const Icon(Icons.download),
                                              ),
                                            );
                                          } else {
                                            return InkWell(
                                              onTap: (){
                                                BlocProvider.of<PlayMusicBloc>(context).add(DownloadSongEvent());
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(12),
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                                ),
                                                child: const Icon(Icons.download),
                                              ),
                                            );
                                          }
                                        }
                                    ),
                                  ],
                                ),
                              ),
                            ]
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }
            ),
          ]
        ),
      ),
    );
  }
}