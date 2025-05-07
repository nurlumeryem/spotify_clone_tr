import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_tr/domain/usecases/get_play_list._usecase.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/play_list/bloc/play_list_event.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/play_list/bloc/play_list_state.dart';

class PlayListBloc extends Bloc<PlayListEvent, PlayListState> {
  final GetPlayListUseCase getPlayListUseCase;

  PlayListBloc(this.getPlayListUseCase) : super(PlayListLoading()) {
    on<FetchPlayList>((event, emit) async {
      emit(PlayListLoading());
      print('Fetching play list...');

      final result = await getPlayListUseCase.call();

      if (result.isSuccess && result.data != null) {
        emit(PlayListLoaded(result.data!));
        print('Play list fetched successfully.');
      } else {
        final errorMsg = result.error ?? 'Bilinmeyen bir hata oluştu.';
        emit(PlayListLoadFailure(errorMsg));
        print('Failed to fetch play list: $errorMsg');
      }
    });
  }
}
