part of 'favorite_button_bloc.dart';

abstract class FavoriteButtonState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoriteButtonInitial extends FavoriteButtonState {}

class FavoriteButtonUpdated extends FavoriteButtonState {
  final String songId;

  FavoriteButtonUpdated(this.songId);
}
