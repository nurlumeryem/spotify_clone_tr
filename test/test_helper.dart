import 'package:get_it/get_it.dart';
import 'package:spotify_clone_tr/core/configs/router/app_router.dart';
import 'package:spotify_clone_tr/main.dart' as app;

void setupTestLocator() {
  final getIt = GetIt.instance;

  // Ana uygulamada yaptığınız kayıtların aynısını yapın
  getIt.registerSingleton<AppRouter>(AppRouter());
  // Diğer servisleri de ekleyin, örneğin:
  // getIt.registerSingleton<AuthService>(MockAuthService());
}
