abstract class SongPlayerState {}

class SongPlayerLoading extends SongPlayerState {}

class SongPlayerLoaded extends SongPlayerState {
  final bool isPlaying;
  final Duration position;
  final Duration duration;

  SongPlayerLoaded({
    required this.isPlaying,
    required this.position,
    required this.duration,
  });
}

class SongPlayerFailure extends SongPlayerState {}
