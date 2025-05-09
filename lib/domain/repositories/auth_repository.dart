import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/data/models/auth/create_user_req.dart';
import 'package:spotify_clone_tr/data/models/signin_user_req.dart';
import 'package:spotify_clone_tr/domain/entities/auth/user.dart';

abstract class AuthRepository {
  Future<Result<void>> signup(CreateUserReq params);
  Future<Result<void>> signin(SigninUserReq signinUserReq);
  Future<Result<UserEntity>> getUser();
}
