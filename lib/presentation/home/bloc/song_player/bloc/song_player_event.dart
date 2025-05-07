abstract class SongPlayerEvent {}

class LoadSongEvent extends SongPlayerEvent {
  final String url;
  LoadSongEvent(this.url);
}

class PlayPauseEvent extends SongPlayerEvent {}
