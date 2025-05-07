// song_player_state.dart
abstract class SongPlayerState {}

class SongPlayerInitial extends SongPlayerState {}

class SongPlayerLoading extends SongPlayerState {}

class SongPlayerLoaded extends SongPlayerState {
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final String songUrl;

  SongPlayerLoaded({
    required this.isPlaying,
    required this.position,
    required this.duration,
    required this.songUrl,
  });

  SongPlayerLoaded copyWith({
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    String? songUrl,
  }) {
    return SongPlayerLoaded(
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      songUrl: songUrl ?? this.songUrl,
    );
  }
}

class SongPlayerFailure extends SongPlayerState {
  final String message;
  SongPlayerFailure(this.message);
}
