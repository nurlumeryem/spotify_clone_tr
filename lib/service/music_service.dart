import 'dart:io';

import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseMusicService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final String _bucketName = 'music_files';

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

      // Storage'a yükleme
      await _supabase.storage.from(_bucketName).upload(filePath, file);

      // Public URL al
      final String publicUrl = _supabase.storage
          .from(_bucketName)
          .getPublicUrl(filePath);

      // Veritabanına kaydetme
      final response = await _supabase.from('songs').insert({
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

  // Müzik listesi getirme
  Future<Result<List<Map<String, dynamic>>>> getMusicList() async {
    try {
      final response = await _supabase
          .from('songs')
          .select('*')
          .order('created_at', ascending: false);

      return Result.success(response);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  // Kullanıcı müziklerini getirme
  Future<Result<List<Map<String, dynamic>>>> getUserMusic(String userId) async {
    try {
      final response = await _supabase
          .from('songs')
          .select('*')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return Result.success(response);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  // Müzik silme
  Future<Result<void>> deleteMusic(String filePath, String songId) async {
    try {
      // Storage'dan dosyayı sil
      await _supabase.storage.from(_bucketName).remove([filePath]);

      // Veritabanından kaydı sil
      await _supabase.from('songs').delete().eq('id', songId);

      return Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
