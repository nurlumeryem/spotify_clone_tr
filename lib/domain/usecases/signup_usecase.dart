import 'package:dartz/dartz.dart';
import 'package:spotify_clone_tr/data/models/auth/create_user_req.dart';
import 'package:spotify_clone_tr/domain/repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository _repository;

  SignupUseCase(this._repository);

  Future<Either<String, void>> call({required CreateUserReq params}) async {
    return await _repository.signup(params);
  }
}
