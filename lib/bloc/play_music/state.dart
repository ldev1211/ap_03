import 'package:ap_03_luongquocdien/bloc/play_music/event.dart';
import 'package:ap_03_luongquocdien/network/entity/lyric/lyric_entity.dart';

class PlayMusicState {}

class PlaySongState extends PlayMusicState{
  final String id;
  final String quality;
  final String title;
  final String artist;
  final String linkThumb;
  final Duration total;

  PlaySongState(this.id, this.quality, this.title, this.artist,this.linkThumb,this.total);
}

class PauseSongState extends PlayMusicState{
}

class ResumeSongState extends PlayMusicState{
}

class SeekState extends PlayMusicState {
  final Duration newDuration;
  final Duration total;

  SeekState(this.newDuration, this.total);
}

class AudioPositionChangeState extends PlayMusicState {
  final Duration currPosition;
  final Duration total;

  AudioPositionChangeState(this.currPosition, this.total);
}

class DownloadSongState extends PlayMusicState {
  final bool isDownloadedFinish;

  DownloadSongState(this.isDownloadedFinish);
}

class ChangeVolumeState extends PlayMusicState {
  final double volume;

  ChangeVolumeState(this.volume);
}

class KaraokeState extends PlayMusicState {
  final String title;
  final String artist;
  final String linkThumb;
  final Duration total;
  final List<Sentence> sentences;

  KaraokeState(this.title, this.artist,this.linkThumb,this.total, this.sentences);
}

class KaraokeChangeLyricState extends PlayMusicState {
  final Duration currDuration;
  final int indexScroll;

  KaraokeChangeLyricState(this.currDuration, this.indexScroll);
}

class EndKaraokeState extends PlayMusicState{
  final double point;

  EndKaraokeState(this.point);
}

class KaraokePointingState extends PlayMusicState {}