import 'package:spotify_clone_tr/domain/entities/auth/user.dart';

abstract class ProfileInfoState {}

class ProfileInfoLoading extends ProfileInfoState {}

class ProfileInfoLoaded extends ProfileInfoState {
  final UserEntity userEntity;
  ProfileInfoLoaded({required this.userEntity});
}

class ProfileInfoFailure extends ProfileInfoState {
  final String message;

  ProfileInfoFailure({this.message = 'An error occurred'});
}
