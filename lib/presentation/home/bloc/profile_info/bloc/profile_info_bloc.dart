import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_tr/domain/usecases/get_user_usacase.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/profile_info/bloc/profile_info_event.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/profile_info/bloc/profile_info_state.dart';
import 'package:spotify_clone_tr/service_locator.dart';

class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {
  ProfileInfoBloc() : super(ProfileInfoLoading()) {
    on<LoadUserEvent>(_onLoadUser);
  }

  Future<void> _onLoadUser(
    LoadUserEvent event,
    Emitter<ProfileInfoState> emit,
  ) async {
    emit(ProfileInfoLoading());

    final result = await sl<GetUserUseCase>().call();

    if (result.isSuccess) {
      emit(ProfileInfoLoaded(userEntity: result.data!));
    } else {
      emit(ProfileInfoFailure(message: result.error!));
    }
  }
}
