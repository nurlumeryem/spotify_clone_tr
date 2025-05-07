part of 'favorite_button_bloc.dart';

sealed class FavoriteButtonState extends Equatable {
  const FavoriteButtonState();
  
  @override
  List<Object> get props => [];
}

final class FavoriteButtonInitial extends FavoriteButtonState {}
