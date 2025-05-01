import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/data/sources/song/song.dart';
import 'package:spotify_clone_tr/domain/repositories/song_repository.dart';
import 'package:spotify_clone_tr/service_locator.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Result> getNewsSongs() async {
    return await sl<SongSupabaseService>().getNewsSongs();
  }
}
