import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/domain/entities/song/song.dart';

abstract class SongRepository {
  Future<Result<List<SongEntity>>> getNewsSongs();
  Future<Result<List<SongEntity>>> getPlayList();
  Future<Result<String>> addOrRemoveFavoriteSongs(String songId);
  Future<Result<bool>> isFavoriteSong(String songId);
}
