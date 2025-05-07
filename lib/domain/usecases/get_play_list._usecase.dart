import 'package:spotify_clone_tr/core/usecase/usecase.dart';
import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/domain/entities/song/song.dart';
import 'package:spotify_clone_tr/domain/repositories/song_repository.dart';
import 'package:spotify_clone_tr/service_locator.dart';

class GetPlayListUseCase implements UseCase<Result<List<SongEntity>>, dynamic> {
  @override
  Future<Result<List<SongEntity>>> call({dynamic params}) async {
    return await sl<SongRepository>().getPlayList();
  }
}
