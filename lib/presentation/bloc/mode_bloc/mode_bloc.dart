import 'package:flutter_bloc/flutter_bloc.dart';
import 'mode_event.dart';
import 'mode_state.dart';
import 'package:spotify_clone_tr/core/utils/theme_preferences.dart'; // bu sınıfı import et

class ModeBloc extends Bloc<ModeEvent, ModeState> {
  ModeBloc() : super(ModeState(mode: AppMode.dark)) {
    on<SetDarkMode>((event, emit) async {
      emit(ModeState(mode: AppMode.dark));
      await ThemePreferences.setThemeMode(AppMode.dark);
    });

    on<SetLightMode>((event, emit) async {
      emit(ModeState(mode: AppMode.light));
      await ThemePreferences.setThemeMode(AppMode.light);
    });

    _loadMode(); // uygulama başlarken kayıtlı temayı yükle
  }

  void _loadMode() async {
    final savedMode = await ThemePreferences.getThemeMode();
    if (savedMode == AppMode.light) {
      add(SetLightMode());
    } else {
      add(SetDarkMode());
    }
  }
}
