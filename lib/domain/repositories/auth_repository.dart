import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/data/models/auth/create_user_req.dart';

abstract class AuthRepository {
  Future<Result<void>> signup(CreateUserReq params);
  Future<Result<void>> signin(CreateUserReq params);
}
