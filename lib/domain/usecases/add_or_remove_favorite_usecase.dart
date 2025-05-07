import 'package:spotify_clone_tr/core/usecase/usecase.dart';
import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/domain/repositories/song_repository.dart';

import 'package:spotify_clone_tr/service_locator.dart';

class AddOrRemoveFavoriteUsecase implements UseCase<Result<String>, String?> {
  @override
  Future<Result<String>> call({String? params}) async {
    return await sl<SongRepository>().addOrRemoveFavoriteSongs(params!);
  }
}
