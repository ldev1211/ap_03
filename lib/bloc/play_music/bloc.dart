import 'dart:convert';
import 'dart:io';
import 'package:ap_03_luongquocdien/network/entity/lyric/lyric_entity.dart';
import 'package:ap_03_luongquocdien/network/route/music/music_service.dart';
import 'package:bloc/bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart' as dio;
import 'package:google_speech/google_speech.dart';
import 'package:record/record.dart';
import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pb.dart'
    hide RecognitionConfig;
import 'package:path_provider/path_provider.dart';
import 'event.dart';
import 'state.dart';

class PlayMusicBloc extends Bloc<PlayMusicEvent, PlayMusicState> {
  bool isPlaying = false;
  AudioPlayer player = AudioPlayer();
  late String id;
  late String url;
  late String quality;
  late String title;
  late String artist;
  late MusicService service;
  late Duration total;
  late double volume;
  late List<Sentence> lyrics;
  late Duration curr;
  late int timeTmp;
  late int durationDiff;
  late int indexScroll;
  final record = Record();
  final serviceAccount =
      ServiceAccount.fromFile(File('stt-flutter-6b7e79229bb6.json'));
  var speechToText;
  final config = RecognitionConfig(
      encoding: AudioEncoding.FLAC,
      model: RecognitionModel.basic,
      enableAutomaticPunctuation: true,
      sampleRateHertz: 44100,
      enableWordTimeOffsets: true,
      languageCode: 'vi-VN');

  int indexSentence = 0, indexWord = 0;

  Future<List<int>> _getAudioContent(String name) async {
    return File("${Directory.current.path}\\record\\myFile.flac")
        .readAsBytesSync()
        .toList();
  }

  void startRecord() async {
    if (await record.hasPermission()) {
      await record.start(
        path: 'record/myFile.wav',
        numChannels: 1,
        encoder: AudioEncoder.flac,
        bitRate: 128000,
        samplingRate: 44100,
      );
    }
  }

  PlayMusicBloc(PlayMusicState initial) : super(initial) {
    on<InitEvent>((event, emit) {
      service = MusicService(dio.Dio());
      volume = 1.0;
    });

    on<SeekEvent>((event, emit) async {
      player.seek(event.duration);
      add(ResumeSongEvent());
      emit(SeekState(event.duration, total));
    });

    on<AudioPositionChangeEvent>((event, emit) async {
      emit(AudioPositionChangeState(event.currPosition, total));
    });

    on<PlaySongEvent>((event, emit) async {
      id = event.id;
      print("id: $id");
      title = event.title;
      artist = event.artist;
      total = event.total;
      String quality = event.quality;
      String linkThumb = event.linkThumb;
      url = "http://api.mp3.zing.vn/api/streaming/audio/$id/$quality";
      player.play(UrlSource(url));
      player.setReleaseMode(ReleaseMode.loop);
      emit(PlaySongState(id, quality, title, artist, linkThumb, total));
      player.onPositionChanged.listen((newPosition) {
        add(AudioPositionChangeEvent(newPosition));
      });
    });

    on<ResumeSongEvent>((event, emit) async {
      player.resume();
      emit(ResumeSongState());
    });

    on<PauseSongEvent>((event, emit) async {
      player.pause();
      emit(PauseSongState());
    });

    on<DownloadSongEvent>((event, emit) async {
      emit(DownloadSongState(false));
      await dio.Dio().download(url, "download/$title.mp3");
      emit(DownloadSongState(true));
    });

    on<ChangeVolumeEvent>((event, emit) {
      volume = event.newVolume;
      player.setVolume(volume);
      emit(ChangeVolumeState(event.newVolume));
    });

    on<KaraokeEvent>((event, emit) async {
      emit(KaraokeState("title", "artist", "linkThumb", Duration.zero, []));
      final id = event.id;
      final response = await service.getLyric(id);
      if (response.data == null) {
        emit(KaraokeState("", "artist", "linkThumb", Duration.zero, []));
        return;
      }
      print(response.data);
      String fileLink = response.data!;
      indexScroll = 0;
      total = event.total;
      quality = event.quality;
      url = "http://api.mp3.zing.vn/api/streaming/audio/$id/$quality";
      player.play(UrlSource(url));
      String s = "";
      HttpClient()
          .getUrl(Uri.parse(fileLink))
          .then((HttpClientRequest request) => request.close())
          .then((HttpClientResponse response) async {
        response.transform(const Utf8Decoder()).listen(
          (event) async {
            s += event;
          },
        );
      });
      lyrics = [];
      await Future.delayed(const Duration(seconds: 3), () {
        List<String> arrLyric = s.substring(s.indexOf('[00')).split('\n');
        for (int i = 0; i < arrLyric.length - 1; ++i) {
          List<String> stringWords = arrLyric[i].substring(10).split(' ');
          List<Word> words = [];
          try {
            for (int j = 0; j < stringWords.length; ++j) {
              final arrTime = arrLyric[i].substring(1, 9).split(':');
              words.add(Word(
                  int.parse(arrTime[0]) * 60 * 1000 +
                      (double.parse(arrTime[1]) * 1000).toInt(),
                  0,
                  stringWords[j]));
            }
            lyrics.add(Sentence(words));
            // ignore: empty_catches
          } catch (e) {}
        }
      });
      emit(KaraokeState(
          event.title, event.artist, event.linkThumb, event.total, lyrics));
      player.onPositionChanged.listen((newPosition) {
        add(KaraokeChangeLyricEvent(newPosition));
      });
      // startRecord();
    });

    on<EndKaraokeEvent>((event, emit) async {
      emit(KaraokePointingState());
      speechToText = SpeechToText.viaServiceAccount(serviceAccount);
      player.stop();
      // String? path = await record.stop();
      // print("path: $path");
      // final audio = await _getAudioContent('myFile.flac');
      // RecognizeResponse response = await speechToText.recognize(config, audio);
      // final List<WordInfo> wordUsers =
      //     response.results[0].alternatives.toList()[0].words;
      // int wordRightTotal = 0;
      // int total = lyrics.length;
      // bool isFound = false;
      // for (int i = 0; i < wordUsers.length; ++i) {
      //   for (int j = indexSentence; j < lyrics.length; ++j) {
      //     for (int k = indexWord; k < lyrics[j].words.length; ++k) {
      //       double millisecondWord =
      //           int.parse(wordUsers[i].startTime.seconds.toString()) * 1000 +
      //               int.parse(wordUsers[i].startTime.nanos.toString()) /
      //                   1000000;
      //       if ((lyrics[j].words[k].startTime - millisecondWord).abs() <= 200 &&
      //           lyrics[j].words[k].data == wordUsers[i].word) {
      //         print(
      //             "word right: ${wordUsers[i].word}, in time: ${lyrics[j].words[k].startTime}");
      //         wordRightTotal = wordRightTotal + 1;
      //         indexSentence = j + 1;
      //         indexWord = k + 1;
      //         isFound = true;
      //         break;
      //       }
      //     }
      //     if (isFound) {
      //       isFound = false;
      //       break;
      //     }
      //   }
      // }
      // double point = (wordRightTotal / total) * 10;
      // double point = 0.0;
      emit(EndKaraokeState(1.0));
    });

    on<KaraokeChangeLyricEvent>((event, emit) async {
      for (int i = 0; i < lyrics.length; ++i) {
        if (event.currDuration.inMilliseconds <= lyrics[i].words[0].startTime) {
          indexScroll = i - 1;
          break;
        }
      }
      emit(KaraokeChangeLyricState(
          event.currDuration, (indexScroll == -1) ? 0 : indexScroll));
    });

    on<ChangeSpeedEvent>((event, emit) {
      player.setPlaybackRate(event.speed);
    });
  }
}
