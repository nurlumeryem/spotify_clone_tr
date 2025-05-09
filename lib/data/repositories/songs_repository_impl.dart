import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/data/sources/song/song_supabase_service.dart';
import 'package:spotify_clone_tr/domain/entities/song/song.dart';
import 'package:spotify_clone_tr/domain/repositories/song_repository.dart';
import 'package:spotify_clone_tr/service_locator.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Result<List<SongEntity>>> getNewsSongs() async {
    return await sl<SongSupabaseService>().getNewsSongs();
  }

  @override
  Future<Result<List<SongEntity>>> getPlayList() async {
    return await sl<SongSupabaseService>().getPlayList();
  }

  @override
  Future<Result<bool>> addOrRemoveFavoriteSongs(String songId) async {
    return await sl<SongSupabaseService>().addOrRemoveFavoriteSong(songId);
  }

  @override
  Future<Result<bool>> isFavoriteSong(String songId) async {
    return await sl<SongSupabaseService>().isFavoriteSong(songId);
  }

  @override
  Future<Result<List<SongEntity>>> getUserFavoriteSongs() async {
    return await sl<SongSupabaseService>().getUserFavoriteSongs();
  }
}
