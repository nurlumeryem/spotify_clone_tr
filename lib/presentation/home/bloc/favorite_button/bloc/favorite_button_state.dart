part of 'favorite_button_bloc.dart';

abstract class FavoriteButtonState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoriteButtonInitial extends FavoriteButtonState {}

class FavoriteButtonUpdated extends FavoriteButtonState {
  final bool isFavorite;

  FavoriteButtonUpdated({required this.isFavorite});

  @override
  List<Object> get props => [isFavorite];
}
