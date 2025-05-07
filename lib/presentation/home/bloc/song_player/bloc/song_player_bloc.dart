import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/song_player/bloc/song_player_state.dart';

// Define the events
abstract class SongPlayerEvent {}

class LoadSongEvent extends SongPlayerEvent {
  final String url;
  LoadSongEvent(this.url);
}

class PlayPauseEvent extends SongPlayerEvent {}

class SongPlayerBloc extends Bloc<SongPlayerEvent, SongPlayerState> {
  final AudioPlayer audioPlayer;

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerBloc() : audioPlayer = AudioPlayer(), super(SongPlayerLoading()) {
    on<LoadSongEvent>(_onLoadSong);
    on<PlayPauseEvent>(_onPlayPause);

    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      add(PlayPauseEvent());
    });

    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        songDuration = duration;
      }
    });
  }

  Future<void> _onLoadSong(
    LoadSongEvent event,
    Emitter<SongPlayerState> emit,
  ) async {
    emit(SongPlayerLoading());
    try {
      await audioPlayer.setUrl(event.url);
      emit(
        SongPlayerLoaded(
          isPlaying: audioPlayer.playing,
          position: songPosition,
          duration: songDuration,
        ),
      );
    } catch (e) {
      emit(SongPlayerFailure());
    }
  }

  Future<void> _onPlayPause(
    PlayPauseEvent event,
    Emitter<SongPlayerState> emit,
  ) async {
    if (audioPlayer.playing) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play();
    }
    emit(
      SongPlayerLoaded(
        isPlaying: audioPlayer.playing,
        position: songPosition,
        duration: songDuration,
      ),
    );
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
