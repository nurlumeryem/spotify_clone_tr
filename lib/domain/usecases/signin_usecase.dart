import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/data/models/auth/create_user_req.dart';
import 'package:spotify_clone_tr/domain/repositories/auth_repository.dart';

class SigninUseCase {
  final AuthRepository _repository;

  SigninUseCase(this._repository);

  Future<Result<void>> call({required CreateUserReq params}) async {
    return await _repository.signin(params);
  }
}
