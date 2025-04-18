import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/data/models/auth/create_user_req.dart';
import 'package:spotify_clone_tr/domain/repositories/auth_repository.dart';
// Result sınıfını ekliyoruz

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Result<void>> signup(CreateUserReq params) async {
    try {
      // API veya veri işleme işlemi yapılır.
      // Örneğin başarılı bir kayıt işlemi:
      return Result.success(null); // Başarılı işlem sonucu
    } catch (e) {
      // Eğer bir hata oluşursa, hata mesajı ile Result.failure döneriz
      return Result.failure("Signup failed: ${e.toString()}");
    }
  }

  @override
  Future<Result<void>> signin(CreateUserReq params) async {
    try {
      // API veya veri işleme işlemi yapılır.
      return Result.success(null); // Başarılı işlem sonucu
    } catch (e) {
      // Eğer bir hata oluşursa, hata mesajı ile Result.failure döneriz
      return Result.failure("Signin failed: ${e.toString()}");
    }
  }
}
