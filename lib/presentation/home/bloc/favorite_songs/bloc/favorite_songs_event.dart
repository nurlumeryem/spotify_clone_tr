part of 'favorite_songs_bloc.dart';

sealed class FavoriteSongsEvent extends Equatable {
  const FavoriteSongsEvent();

  @override
  List<Object> get props => [];
}

final class LoadFavoriteSongsEvent extends FavoriteSongsEvent {
  const LoadFavoriteSongsEvent();
}

final class RemoveFavoriteSongEvent extends FavoriteSongsEvent {
  final SongEntity song;

  const RemoveFavoriteSongEvent({required this.song});

  @override
  List<Object> get props => [song];
}
