import 'package:dartz/dartz.dart';
import 'package:spotify_clone_tr/data/models/auth/create_user_req.dart';
import 'package:spotify_clone_tr/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<String, void>> signup(CreateUserReq params) async {
    // TODO: Implement signup logic
    return const Right(null);
  }

  @override
  Future<Either<String, void>> signin(CreateUserReq params) async {
    // TODO: Implement signin logic
    return const Right(null);
  }
}
