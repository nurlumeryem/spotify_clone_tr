import 'package:spotify_clone_tr/core/usecase/usecase.dart';
import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/domain/entities/auth/user.dart';
import 'package:spotify_clone_tr/domain/repositories/auth_repository.dart';
import 'package:spotify_clone_tr/service_locator.dart';

class GetUserUseCase implements UseCase<Result<UserEntity>, void> {
  @override
  Future<Result<UserEntity>> call({void params}) async {
    return sl<AuthRepository>().getUser();
  }
}
