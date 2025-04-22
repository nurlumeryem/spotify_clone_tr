import 'package:get_it/get_it.dart';
import 'package:spotify_clone_tr/data/repositories/auth_repository_impl.dart';
import 'package:spotify_clone_tr/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify_clone_tr/domain/repositories/auth_repository.dart';
import 'package:spotify_clone_tr/domain/usecases/signin_usecase.dart';
import 'package:spotify_clone_tr/domain/usecases/signup_usecase.dart';

final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  // AuthFirebaseService
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  // UseCases -> Bağımlılığı: AuthRepository
  sl.registerSingleton<SignupUseCase>(SignupUseCase(sl<AuthRepository>()));

  sl.registerSingleton<SigninUseCase>(SigninUseCase(sl<AuthRepository>()));
}
