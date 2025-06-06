import 'package:spotify_clone_tr/core/usecase/usecase.dart';
import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/domain/repositories/song_repository.dart';

import 'package:spotify_clone_tr/service_locator.dart';

class IsFavoriteSongUsecase implements UseCase<Result<bool>, String?> {
  @override
  Future<Result<bool>> call({String? params}) async {
    return await sl<SongRepository>().isFavoriteSong(params!);
  }
}
