import 'package:get_it/get_it.dart';
import 'package:spotify_clone_tr/domain/usecases/signin_usecase.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton(() => SignupUseCase());
}
