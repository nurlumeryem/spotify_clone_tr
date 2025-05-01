import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_tr/domain/usecases/get_news_usecase.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/news_songs_state.dart';
import 'news_songs_event.dart';

class NewsSongsBloc extends Bloc<NewsSongsEvent, NewsSongsState> {
  final GetNewsSongsUseCase getNewsSongsUseCase;

  NewsSongsBloc({required this.getNewsSongsUseCase})
    : super(NewsSongsLoading()) {
    on<FetchNewsSongs>((event, emit) async {
      emit(NewsSongsLoading());

      final result = await getNewsSongsUseCase.call();

      if (result.isSuccess && result.data != null) {
        emit(NewsSongsLoaded(songs: result.data!));
      } else {
        emit(NewsSongsLoadFailure());
        emit(NewsSongsLoadFailure(message: result.error));
      }
    });
  }
}
