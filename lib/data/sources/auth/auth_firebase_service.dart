import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_images.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_urls.dart';
import 'package:spotify_clone_tr/core/utils/firebase_error_helper.dart';
import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/data/models/auth/create_user_req.dart';
import 'package:spotify_clone_tr/data/models/auth/user_model.dart';
import 'package:spotify_clone_tr/data/models/signin_user_req.dart';
import 'package:spotify_clone_tr/domain/entities/auth/user.dart';

abstract class AuthFirebaseService {
  Future<Result<String>> signin(
    SigninUserReq signinUserReq,
  ); // Result kullanıyoruz
  Future<Result<String>> signup(CreateUserReq createUserReq);
  Future<Result<UserEntity>> getUser(); // Result kullanıyoruz
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Result<String>> signin(SigninUserReq signinUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinUserReq.email,
        password: signinUserReq.password,
      );
      return Result.success('Giriş başarılı!');
    } on FirebaseAuthException catch (e) {
      return Result.failure(FirebaseErrorHelper.getMessage(e.code));
    }
  }

  @override
  Future<Result<String>> signup(CreateUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(data.user?.uid)
          .set({'name': createUserReq.fullName, 'email': data.user?.email});

      return Result.success('Kayıt başarılı! Hoş geldiniz.');
    } on FirebaseAuthException catch (e) {
      return Result.failure(FirebaseErrorHelper.getMessage(e.code));
    }
  }

  @override
  Future<Result<UserEntity>> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user =
          await firebaseFirestore
              .collection('Users')
              .doc(firebaseAuth.currentUser?.uid)
              .get();

      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageURL =
          firebaseAuth.currentUser?.photoURL ?? AppImages.defaultImage;

      UserEntity userEntity = userModel.toEntity();
      return Result.success(userEntity);
    } on FirebaseException catch (e) {
      // Firebase kaynaklı özel hata varsa
      final message = FirebaseErrorHelper.getMessage(e.code);
      return Result.failure(message);
    } catch (e) {
      // Diğer hatalar
      return Result.failure(
        'Kullanıcı bilgileri alınırken bir hata oluştu: ${e.toString()}',
      );
    }
  }
}
