import 'package:get_it/get_it.dart';
import 'package:spotify_clone_tr/data/repositories/auth_repository_impl.dart';
import 'package:spotify_clone_tr/domain/repositories/auth_repository.dart';
import 'package:spotify_clone_tr/domain/usecases/signup_usecase.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  // Use cases
  sl.registerLazySingleton(() => SignupUseCase(sl<AuthRepository>()));
}
