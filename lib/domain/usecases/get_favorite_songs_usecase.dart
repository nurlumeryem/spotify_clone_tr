import 'package:spotify_clone_tr/core/usecase/usecase.dart';
import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/domain/repositories/song_repository.dart';

import 'package:spotify_clone_tr/service_locator.dart';

class GetFavoriteSongsUsecase implements UseCase<Result, dynamic> {
  @override
  Future<Result<bool>> call({params}) async {
    final result = await sl<SongRepository>().getUserFavoriteSongs();
    if (result.isSuccess && result.data.isNotEmpty) {
      return Result.success(true);
    } else {
      return Result.success(false);
    }
  }
}
