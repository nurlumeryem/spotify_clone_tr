import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_clone_tr/presentation/bloc/mode_bloc/mode_state.dart';

class ThemePreferences {
  static const _modeKey = 'app_mode';

  /// Tema modunu kaydet
  static Future<void> setThemeMode(AppMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_modeKey, mode == AppMode.dark ? 'dark' : 'light');
  }

  /// Tema modunu getir
  static Future<AppMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_modeKey);

    if (value == 'light') return AppMode.light;
    return AppMode.dark; // varsayılan olarak dark
  }
}
