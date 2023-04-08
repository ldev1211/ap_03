import 'dart:io';

import 'package:ap_03_luongquocdien/bloc/play_music/bloc.dart';
import 'package:ap_03_luongquocdien/bloc/play_music/event.dart';
import 'package:ap_03_luongquocdien/bloc/play_music/state.dart';
import 'package:ap_03_luongquocdien/network/entity/lyric/lyric_entity.dart';
import 'package:ap_03_luongquocdien/page/search_result_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class KaraokePage extends StatefulWidget{
  const KaraokePage({super.key});


  @override
  State<KaraokePage> createState() => _KaraokePage();
}

class _KaraokePage extends State<KaraokePage> {

  final _textSearchController = TextEditingController();
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap:() {
                BlocProvider.of<PlayMusicBloc>(context).add(EndKaraokeEvent());
              },
              child: const Text(
                "Karaoke",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 40
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 12)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.all(Radius.circular(50))
              ),
              height: 50,
              child: TextField(
                onSubmitted: (stringSearch){
                  showDialog(context: context, builder: (BuildContext context) => SearchResultDialog(_textSearchController.text,"kara"));
                },
                textInputAction: TextInputAction.go,
                controller: _textSearchController,
                decoration: const InputDecoration(
                    hintText: "Tìm kiếm",
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search)
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 12)),
            Expanded(
              child: BlocBuilder<PlayMusicBloc,PlayMusicState>(
                buildWhen: (prev,curr){
                  return curr is KaraokeState;
                },
                builder: (context,stateKaraoke){
                  if(stateKaraoke is KaraokeState){
                    if(stateKaraoke.sentences.isNotEmpty) {
                      return ScrollablePositionedList.builder(
                      itemScrollController: _scrollController,
                      itemCount: stateKaraoke.sentences.length,
                      itemBuilder: (context, index) {
                          String sentence = "";
                          for(int i=0;i<stateKaraoke.sentences[index].words.length;++i){
                            sentence += "${stateKaraoke.sentences[index].words[i].data} ";
                          }
                          sentence = sentence.trim();
                          return BlocBuilder<PlayMusicBloc,PlayMusicState>(
                            buildWhen: (prev,curr){
                              return curr is KaraokeChangeLyricState;
                            },
                            builder: (context,stateLyricChange){
                              if(stateLyricChange is KaraokeChangeLyricState){
                                List<Word> words = stateKaraoke.sentences[index].words;
                                _scrollController.scrollTo(index: stateLyricChange.indexScroll, duration: const Duration(milliseconds: 200));
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                          child: Text(
                                            sentence,
                                            style: TextStyle(
                                                color: (stateLyricChange.currDuration.inMilliseconds > words[0].startTime)?Colors.red:Colors.grey,
                                                fontSize: (stateLyricChange.currDuration.inMilliseconds > words[0].startTime)?20:15,
                                              fontWeight: FontWeight.bold
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }
                        );
                      },
                    );
                    } else if(stateKaraoke.title == "title"){
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const Center(child: Text("Rất tiếc! Bài hát này không có lyric",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),));
                    }
                  } else {
                    return Container();
                  }
                },
              )
            )
          ],
        ),
      )
    );
  }
}