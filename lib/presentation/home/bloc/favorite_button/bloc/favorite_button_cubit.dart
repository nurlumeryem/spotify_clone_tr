import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_tr/domain/usecases/add_or_remove_favorite_usecase.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/favorite_button/bloc/favorite_button_state.dart';
import 'package:spotify_clone_tr/service_locator.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  Future<void> favoriteButtonUpdated(String songId) async {
    final result = await sl<AddOrRemoveFavoriteSongUseCase>().call(
      params: songId,
    );

    if (result.isSuccess) {
      emit(FavoriteButtonUpdated(isFavorite: result.data ?? false));
    } else {
      print('Error: ${result.error}');
      emit(FavoriteButtonInitial());
    }
  }
}
