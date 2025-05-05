import 'package:spotify_clone_tr/core/usecase/usecase.dart';
import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/data/repositories/songs_repository_impl.dart';
import 'package:spotify_clone_tr/domain/entities/song/song.dart';
import 'package:spotify_clone_tr/domain/repositories/song_repository.dart';

import 'package:spotify_clone_tr/service_locator.dart';

class GetNewsSongsUseCase
    implements UseCase<Result<List<SongEntity>>, dynamic> {
  @override
  Future<Result<List<SongEntity>>> call({params}) async {
    return await sl<SongRepository>().getNewsSongs()
        as Result<List<SongEntity>>;
  }
}
