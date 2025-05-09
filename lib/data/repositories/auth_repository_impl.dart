import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/data/models/auth/create_user_req.dart';
import 'package:spotify_clone_tr/data/models/signin_user_req.dart';
import 'package:spotify_clone_tr/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify_clone_tr/domain/entities/auth/user.dart';
import 'package:spotify_clone_tr/domain/repositories/auth_repository.dart';
import 'package:spotify_clone_tr/service_locator.dart';
// Result sınıfını ekliyoruz

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Result<void>> signin(SigninUserReq signinUserReq) async {
    return await sl<AuthFirebaseService>().signin(signinUserReq);
  }

  @override
  Future<Result<void>> signup(CreateUserReq createUserReq) async {
    return await sl<AuthFirebaseService>().signup(createUserReq);
  }

  @override
  Future<Result<UserEntity>> getUser() async {
    return await sl<AuthFirebaseService>().getUser();
  }
}
