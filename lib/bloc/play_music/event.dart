abstract class PlayMusicEvent {}

class InitEvent extends PlayMusicEvent {}

class PlaySongEvent extends PlayMusicEvent {
  final String id;
  final String quality;
  final String title;
  final String artist;
  final String linkThumb;
  final Duration total;

  PlaySongEvent(this.id, this.quality, this.title, this.artist,this.linkThumb,this.total);
}

class ResumeSongEvent extends PlayMusicEvent {}

class PauseSongEvent extends PlayMusicEvent {}

class SeekEvent extends PlayMusicEvent {
  final Duration duration;

  SeekEvent(this.duration);
}

class AudioPositionChangeEvent extends PlayMusicEvent {
  final Duration currPosition;

  AudioPositionChangeEvent(this.currPosition);
}

class DownloadSongEvent extends PlayMusicEvent {}

class ChangeVolumeEvent extends PlayMusicEvent {
  final double newVolume;

  ChangeVolumeEvent(this.newVolume);
}

class KaraokeEvent extends PlayMusicEvent {
  final String id;
  final String quality;
  final String title;
  final String artist;
  final String linkThumb;
  final Duration total;

  KaraokeEvent(this.id, this.quality, this.title, this.artist,this.linkThumb,this.total);
}

class EndKaraokeEvent extends PlayMusicEvent {}

class KaraokeChangeLyricEvent extends PlayMusicEvent {
  final Duration currDuration;

  KaraokeChangeLyricEvent(this.currDuration);
}

class ChangeSpeedEvent extends PlayMusicEvent {
  final double speed;

  ChangeSpeedEvent(this.speed);
}