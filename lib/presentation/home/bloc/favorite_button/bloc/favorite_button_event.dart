part of 'favorite_button_bloc.dart';

abstract class FavoriteButtonEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateFavoriteButton extends FavoriteButtonEvent {
  final String songId;

  UpdateFavoriteButton({required this.songId});

  @override
  List<Object> get props => [songId];
}
