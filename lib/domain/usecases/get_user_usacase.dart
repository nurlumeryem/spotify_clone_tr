import 'package:spotify_clone_tr/core/usecase/usecase.dart';
import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/domain/repositories/auth_repository.dart';
import 'package:spotify_clone_tr/service_locator.dart';

class GetUserUsacase implements UseCase<Result, GetUserUsacase> {
  Future<Result<void>> call({GetUserUsacase? params}) async {
    return sl<AuthRepository>().getUser();
  }
}
