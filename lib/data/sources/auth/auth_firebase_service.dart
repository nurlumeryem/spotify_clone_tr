import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/data/models/auth/create_user_req.dart';
import 'package:spotify_clone_tr/data/models/signin_user_req.dart';

abstract class AuthFirebaseService {
  Future<Result<String>> signin(
    SigninUserReq signinUserReq,
  ); // Result kullanıyoruz
  Future<Result<String>> signup(
    CreateUserReq createUserReq,
  ); // Result kullanıyoruz
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Result<String>> signin(SigninUserReq signinUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinUserReq.email,
        password: signinUserReq.password,
      );

      return Result.success(
        'Signin was Successful',
      ); // Başarı durumunda Result.success döndürülür
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'invalid-email') {
        message = 'No user found for that email';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user';
      }

      return Result.failure(
        message,
      ); // Hata durumunda Result.failure döndürülür
    }
  }

  @override
  Future<Result<String>> signup(CreateUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );

      // Firestore'a kullanıcıyı kaydetme
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(data.user?.uid)
          .set({'name': createUserReq.fullName, 'email': data.user?.email});

      return Result.success(
        'Signup was Successful',
      ); // Başarı durumunda Result.success döndürülür
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }

      return Result.failure(
        message,
      ); // Hata durumunda Result.failure döndürülür
    }
  }
}
