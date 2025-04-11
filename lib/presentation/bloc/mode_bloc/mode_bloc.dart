import 'package:flutter_bloc/flutter_bloc.dart';
import 'mode_event.dart';
import 'mode_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String modeKey = 'app_mode';

class ModeBloc extends Bloc<ModeEvent, ModeState> {
  ModeBloc() : super(ModeState(mode: AppMode.dark)) {
    on<SetDarkMode>((event, emit) async {
      emit(ModeState(mode: AppMode.dark));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(modeKey, 'dark');
    });

    on<SetLightMode>((event, emit) async {
      emit(ModeState(mode: AppMode.light));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(modeKey, 'light');
    });

    _loadMode();
  }

  void _loadMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getString(modeKey);

    if (savedMode == 'dark') {
      add(SetDarkMode());
    } else if (savedMode == 'light') {
      add(SetLightMode());
    }
  }
}
