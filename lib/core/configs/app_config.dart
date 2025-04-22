import 'package:get_it/get_it.dart';
import 'package:spotify_clone_tr/core/configs/router/app_router.dart';
import 'package:spotify_clone_tr/data/repositories/auth_repository_impl.dart';
import 'package:spotify_clone_tr/domain/repositories/auth_repository.dart';
import 'package:spotify_clone_tr/domain/usecases/signup_usecase.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Router
  getIt.registerSingleton<AppRouter>(AppRouter());

  // Repository
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  // UseCase
  getIt.registerLazySingleton<SignupUseCase>(
    () => SignupUseCase(getIt<AuthRepository>()),
  );
}
