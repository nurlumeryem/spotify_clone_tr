import 'dart:io';
import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:supabase/supabase.dart';

class SupabaseMusicService {
  final SupabaseClient supabase;
  final String _bucketName = 'music_files';

  SupabaseMusicService(this.supabase);

  // Müzik yükleme
  Future<Result<String>> uploadMusic(
    File file,
    String userId,
    String title,
    String artist,
  ) async {
    try {
      final String filePath =
          'user_$userId/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';

      // Dosyayı Supabase Storage'a yükle
      final storageResponse = await supabase.storage
          .from(_bucketName)
          .upload(filePath, file);

      if (storageResponse.isEmpty) {
        return Result.failure("Dosya yüklenemedi.");
      }

      // Public URL al
      final String publicUrl = supabase.storage
          .from(_bucketName)
          .getPublicUrl(filePath);

      // Metadata'yı songs tablosuna kaydet
      final response = await supabase.from('songs').insert({
        'title': title,
        'artist': artist,
        'file_path': filePath,
        'url': publicUrl,
        'user_id': userId,
        'created_at': DateTime.now().toIso8601String(),
      });

      return Result.success(publicUrl);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  // Tüm müzikleri getir
  Future<Result<List<Map<String, dynamic>>>> getMusicList() async {
    try {
      final response = await supabase
          .from('songs')
          .select('*')
          .order('created_at', ascending: false);

      return Result.success(response as List<Map<String, dynamic>>);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  // Kullanıcıya özel müzikleri getir
  Future<Result<List<Map<String, dynamic>>>> getUserMusic(String userId) async {
    try {
      final response = await supabase
          .from('songs')
          .select('*')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return Result.success(response as List<Map<String, dynamic>>);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  // Müzik silme işlemi
  Future<Result<void>> deleteMusic(String filePath, String songId) async {
    try {
      await supabase.storage.from(_bucketName).remove([filePath]);
      await supabase.from('songs').delete().eq('id', songId);
      return Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
