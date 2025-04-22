import 'package:spotify_clone_tr/core/usecase/usecase.dart';
import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/data/models/signin_user_req.dart';
import 'package:spotify_clone_tr/domain/repositories/auth_repository.dart';
import 'package:spotify_clone_tr/service_locator.dart';

class SigninUseCase implements UseCase<Result, SigninUserReq> {
  Future<Result<void>> call({SigninUserReq? params}) async {
    return sl<AuthRepository>().signin(params!);
  }
}
