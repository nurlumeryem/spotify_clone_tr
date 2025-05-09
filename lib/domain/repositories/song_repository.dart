import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/domain/entities/song/song.dart';

abstract class SongRepository {
  Future<Result<List<SongEntity>>> getNewsSongs();
  Future<Result<List<SongEntity>>> getPlayList();
  Future<Result<bool>> addOrRemoveFavoriteSongs(String songId);
  Future<Result<bool>> isFavoriteSong(String songId);
  Future<Result<List<SongEntity>>> getUserFavoriteSongs();
}
