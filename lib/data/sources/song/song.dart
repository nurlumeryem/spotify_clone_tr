import 'package:spotify_clone_tr/data/models/song/song.dart';
import 'package:spotify_clone_tr/domain/entities/song/song.dart';
import 'package:supabase/supabase.dart';
import 'package:spotify_clone_tr/core/utils/result.dart';

abstract class SongSupabaseService {
  Future<Result<List<SongEntity>>> getNewsSongs();
  Future<Result<List<SongEntity>>> getPlayList();
}

class SongSupabaseServiceImpl extends SongSupabaseService {
  final SupabaseClient supabase;

  SongSupabaseServiceImpl(this.supabase);

  @override
  Future<Result<List<SongEntity>>> getNewsSongs() async {
    try {
      final response = await supabase
          .from('songs')
          .select('*')
          .order('created_at', ascending: false)
          .limit(3);

      final songs =
          (response as List).map((json) {
            final model = SongModel.fromJson(json);
            model.songId = json['id'];
            return model.toEntity();
          }).toList();

      return Result.success(songs);
    } catch (e) {
      return Result.failure('Bir hata oluştu: $e');
    }
  }

  @override
  Future<Result<List<SongEntity>>> getPlayList() async {
    try {
      final response = await supabase
          .from('songs')
          .select('*')
          .order('created_at', ascending: false);

      final songs =
          (response as List).map((json) {
            final model = SongModel.fromJson(json);
            model.songId = json['id'];
            return model.toEntity();
          }).toList();

      return Result.success(songs);
    } catch (e) {
      return Result.failure('Bir hata oluştu: $e');
    }
  }
}
