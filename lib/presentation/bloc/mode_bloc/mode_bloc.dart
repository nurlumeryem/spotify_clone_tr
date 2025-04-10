import 'package:flutter_bloc/flutter_bloc.dart';
import 'mode_event.dart';
import 'mode_state.dart';

class ModeBloc extends Bloc<ModeEvent, ModeState> {
  ModeBloc() : super(ModeState(mode: AppMode.dark)) {
    on<SetDarkMode>((event, emit) {
      emit(ModeState(mode: AppMode.dark));
    });

    on<SetLightMode>((event, emit) {
      emit(ModeState(mode: AppMode.light));
    });
  }
}
