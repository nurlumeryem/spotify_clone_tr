part of 'favorite_songs_bloc.dart';

sealed class FavoriteSongsState extends Equatable {
  const FavoriteSongsState();

  @override
  List<Object> get props => [];
}

final class FavoriteSongsLoading extends FavoriteSongsState {}

final class FavoriteSongsLoaded extends FavoriteSongsState {
  final List<SongEntity> favoriteSongs;

  const FavoriteSongsLoaded({required this.favoriteSongs});
}

final class FavoriteSongsFailure extends FavoriteSongsState {
  final String message;

  const FavoriteSongsFailure({required this.message});

  @override
  List<Object> get props => [message];
}
