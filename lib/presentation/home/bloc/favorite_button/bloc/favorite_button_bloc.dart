import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spotify_clone_tr/domain/usecases/add_or_remove_favorite_usecase.dart';
import 'package:spotify_clone_tr/service_locator.dart';
import 'package:flutter/material.dart';

part 'favorite_button_event.dart';
part 'favorite_button_state.dart';

class FavoriteButtonBloc
    extends Bloc<FavoriteButtonEvent, FavoriteButtonState> {
  FavoriteButtonBloc() : super(FavoriteButtonInitial()) {
    on<UpdateFavoriteButton>((event, emit) async {
      var result = await sl<AddOrRemoveFavoriteSongUseCase>().call(
        params: event.songId,
      );

      if (result.isSuccess) {
        emit(FavoriteButtonUpdated(event.songId));
      } else {
        print('Error: ${result.error}');
        emit(FavoriteButtonInitial());
      }
    });
  }
}
