import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/song_player/bloc/song_player_state.dart';

// Events
abstract class SongPlayerEvent {}

class LoadSongEvent extends SongPlayerEvent {
  final String url;
  LoadSongEvent(this.url);
}

class PlayPauseEvent extends SongPlayerEvent {}

class SeekEvent extends SongPlayerEvent {
  final Duration position;
  SeekEvent(this.position);
}

// BLoC
class SongPlayerBloc extends Bloc<SongPlayerEvent, SongPlayerState> {
  final AudioPlayer audioPlayer;
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerBloc() : audioPlayer = AudioPlayer(), super(SongPlayerInitial()) {
    on<LoadSongEvent>(_onLoadSong);
    on<PlayPauseEvent>(_onPlayPause);
    on<SeekEvent>(_onSeek);

    // Pozisyon ve süre dinleyicileri
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      if (state is SongPlayerLoaded) {
        emit((state as SongPlayerLoaded).copyWith(position: position));
      }
    });

    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        songDuration = duration;
        if (state is SongPlayerLoaded) {
          emit((state as SongPlayerLoaded).copyWith(duration: duration));
        }
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
      debugPrint('Loading song from URL: ${event.url}');

      emit(
        SongPlayerLoaded(
          isPlaying: false,
          position: Duration.zero,
          duration: songDuration,
          songUrl: event.url,
        ),
      );
    } catch (e) {
      emit(SongPlayerFailure('Şarkı yüklenemedi. URL: ${event.url}\nHata: $e'));
      debugPrint('Hata detayı: $e');
    }
  }

  Future<void> _onPlayPause(
    PlayPauseEvent event,
    Emitter<SongPlayerState> emit,
  ) async {
    if (state is! SongPlayerLoaded) return;

    final currentState = state as SongPlayerLoaded;
    if (currentState.isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play();
    }
    emit(currentState.copyWith(isPlaying: !currentState.isPlaying));
  }

  Future<void> _onSeek(SeekEvent event, Emitter<SongPlayerState> emit) async {
    if (state is! SongPlayerLoaded) return;
    await audioPlayer.seek(event.position);
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
