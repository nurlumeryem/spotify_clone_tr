import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spotify_clone_tr/domain/entities/song/song.dart';
import 'package:spotify_clone_tr/domain/usecases/get_favorite_songs_usecase.dart';
import 'package:spotify_clone_tr/service_locator.dart';

part 'favorite_songs_event.dart';
part 'favorite_songs_state.dart';

class FavoriteSongsBloc extends Bloc<FavoriteSongsEvent, FavoriteSongsState> {
  List<SongEntity> favoriteSongs = [];

  FavoriteSongsBloc() : super(FavoriteSongsLoading()) {
    on<LoadFavoriteSongsEvent>(_onLoadFavoriteSongs);
    on<RemoveFavoriteSongEvent>(_onRemoveFavoriteSong);
  }

  Future<void> _onLoadFavoriteSongs(
    LoadFavoriteSongsEvent event,
    Emitter<FavoriteSongsState> emit,
  ) async {
    emit(FavoriteSongsLoading());

    try {
      final result = await sl<GetFavoriteSongsUsecase>().call();

      if (result.isSuccess && result.data != null) {
        favoriteSongs = result.data!;
        emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
      } else {
        emit(
          FavoriteSongsFailure(
            message: result.error ?? 'Bilinmeyen bir hata oluştu.',
          ),
        );
      }
    } catch (e) {
      emit(
        FavoriteSongsFailure(
          message: 'Favori şarkılar yüklenirken hata oluştu: $e',
        ),
      );
    }
  }

  void _onRemoveFavoriteSong(
    RemoveFavoriteSongEvent event,
    Emitter<FavoriteSongsState> emit,
  ) {
    favoriteSongs.remove(event.song);
    emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
  }
}
