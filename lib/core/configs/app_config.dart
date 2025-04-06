import 'package:get_it/get_it.dart';
import 'package:spotify_clone_tr/core/configs/router/app_router.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<AppRouter>(AppRouter());
}
