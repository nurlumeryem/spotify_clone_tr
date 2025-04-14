import 'package:dartz/dartz.dart';
import 'package:spotify_clone_tr/data/models/auth/create_user_req.dart';

class SignupUseCase {
  Future<Either<String, bool>> call({required CreateUserReq params}) async {
    // Implement your signup logic here
    try {
      // API call veya authentication işlemleri
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
