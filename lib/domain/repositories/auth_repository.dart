import 'package:dartz/dartz.dart';
import 'package:spotify_clone_tr/data/models/auth/create_user_req.dart';

abstract class AuthRepository {
  Future<Either<String, void>> signup(CreateUserReq params);
  Future<Either<String, void>> signin(CreateUserReq params);
}
