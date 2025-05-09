import 'package:spotify_clone_tr/core/usecase/usecase.dart';
import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/domain/entities/song/song.dart';
import 'package:spotify_clone_tr/domain/repositories/song_repository.dart';

import 'package:spotify_clone_tr/service_locator.dart';

class GetFavoriteSongsUsecase
    implements UseCase<Result<List<SongEntity>>, dynamic> {
  @override
  Future<Result<List<SongEntity>>> call({params}) async {
    final result = await sl<SongRepository>().getUserFavoriteSongs();

    if (result.isSuccess && (result.data?.isNotEmpty ?? false)) {
      return Result.success(result.data);
    } else {
      return Result.failure(result.error ?? 'Favori şarkı bulunamadı');
    }
  }
}
