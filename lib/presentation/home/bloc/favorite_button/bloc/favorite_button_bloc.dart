import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spotify_clone_tr/domain/usecases/add_or_remove_favorite_usecase.dart';
import 'package:spotify_clone_tr/service_locator.dart';

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
        // If the operation was successful, emit the updated state
        emit(FavoriteButtonUpdated(isFavorite: result.data!));
      } else {
        // Handle the error case if needed
        // You can log the error or emit an error state
        print('Error: ${result.error}');
      }
    });
  }
}
