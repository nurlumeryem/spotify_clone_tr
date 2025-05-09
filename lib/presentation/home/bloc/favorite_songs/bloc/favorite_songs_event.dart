part of 'favorite_songs_bloc.dart';

sealed class FavoriteSongsEvent extends Equatable {
  const FavoriteSongsEvent();

  @override
  List<Object> get props => [];
}

final class LoadFavoriteSongsEvent extends FavoriteSongsEvent {
  const LoadFavoriteSongsEvent();
}
