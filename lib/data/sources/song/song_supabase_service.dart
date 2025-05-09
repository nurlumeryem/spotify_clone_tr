import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone_tr/data/models/song/song.dart';
import 'package:spotify_clone_tr/domain/entities/song/song.dart';
import 'package:supabase/supabase.dart';
import 'package:spotify_clone_tr/core/utils/result.dart';

abstract class SongSupabaseService {
  Future<Result<List<SongEntity>>> getNewsSongs();
  Future<Result<List<SongEntity>>> getPlayList();
  Future<Result<bool>> addOrRemoveFavoriteSong(String songId);
  Future<Result<bool>> isFavoriteSong(String songId);
  Future<Result<List<SongEntity>>> getUserFavoriteSongs();
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

      print('🍎 RAW from Supabase: $response');

      final songFutures =
          (response as List).map((json) async {
            print('🔹 mapping json keys: ${json.keys.toList()}');

            final String? relativePath = json['file_path'] as String?;
            String? signedCoverUrl;

            if (relativePath != null && relativePath.isNotEmpty) {
              try {
                signedCoverUrl = await supabase.storage
                    .from('covers')
                    .createSignedUrl(relativePath, 60 * 5);
              } catch (e) {
                print(
                  'Error creating signed URL for $relativePath in bucket "covers": $e',
                );
              }
            }

            final model = SongModel.fromJson(json);
            model.coverFileName = signedCoverUrl;

            return model.toEntity();
          }).toList();

      final songs = await Future.wait(songFutures);

      print('🎉 MAPPED song count: ${songs.length}');
      return Result.success(songs);
    } catch (e) {
      print('Genel hata getNewsSongs: $e');
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

      final songFutures =
          (response as List).map((json) async {
            final String? relativePath = json['file_path'] as String?;
            String? signedCoverUrl;

            if (relativePath != null && relativePath.isNotEmpty) {
              try {
                signedCoverUrl = await supabase.storage
                    .from('covers')
                    .createSignedUrl(relativePath, 60 * 5);
              } catch (e) {
                print(
                  'Error creating signed URL for $relativePath in bucket "covers" (playlist): $e',
                );
              }
            }
            final model = SongModel.fromJson(json);
            model.coverFileName = signedCoverUrl;
            return model.toEntity();
          }).toList();

      final songs = await Future.wait(songFutures);
      return Result.success(songs);
    } catch (e) {
      return Result.failure('Bir hata oluştu: $e');
    }
  }

  @override
  Future<Result<bool>> addOrRemoveFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoriteSongs =
          await firebaseFirestore
              .collection('Users')
              .doc(uId)
              .collection('Favorites')
              .where('songId', isEqualTo: songId)
              .get();

      if (favoriteSongs.docs.isNotEmpty) {
        // Şarkı zaten favorilerde, kaldır
        await favoriteSongs.docs.first.reference.delete();
        return Result.success(false);
      } else {
        // Şarkı favorilerde değil, ekle
        await firebaseFirestore
            .collection('Users')
            .doc(uId)
            .collection('Favorites')
            .add({'songId': songId, 'addedDate': Timestamp.now()});
        return Result.success(true);
      }
    } catch (e) {
      return Result.failure('Bir hata oluştu: $e');
    }
  }

  @override
  Future<Result<bool>> isFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoriteSongs =
          await firebaseFirestore
              .collection('Users')
              .doc(uId)
              .collection('Favorites')
              .where('songId', isEqualTo: songId)
              .get();

      if (favoriteSongs.docs.isNotEmpty) {
        return Result.success(true);
      } else {
        return Result.success(false);
      }
    } catch (e) {
      return Result.failure('Bir hata oluştu: $e');
    }
  }

  @override
  Future<Result<List<SongEntity>>> getUserFavoriteSongs() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;

      if (user == null) {
        return Result.failure('Kullanıcı oturumu açmamış.');
      }

      List<SongEntity> favoriteSongs = [];
      String uId = user.uid;

      QuerySnapshot favoritesSnapshot =
          await firebaseFirestore
              .collection('Users')
              .doc(uId)
              .collection('Favorites')
              .get();

      if (favoritesSnapshot.docs.isEmpty) {
        return Result.failure('Favori şarkı bulunamadı.');
      }

      for (var element in favoritesSnapshot.docs) {
        String songId = element['songId'];

        // 🔄 Supabase'den çekiyoruz artık
        final response =
            await supabase.from('songs').select('*').eq('id', songId).single();

        if (response == null) {
          print('Şarkı bulunamadı Supabase içinde: $songId');
          continue;
        }

        final String? relativePath = response['file_path'] as String?;
        String? signedCoverUrl;

        if (relativePath != null && relativePath.isNotEmpty) {
          try {
            signedCoverUrl = await supabase.storage
                .from('covers')
                .createSignedUrl(relativePath, 60 * 5);
          } catch (e) {
            print('Signed URL alınamadı: $e');
          }
        }

        final songModel = SongModel.fromJson(response);
        songModel.coverFileName = signedCoverUrl;
        songModel.isFavorite = true;
        songModel.songId = songId;

        favoriteSongs.add(songModel.toEntity());
      }

      return Result.success(favoriteSongs);
    } catch (e) {
      print('Favori şarkılar alınırken hata: $e');
      return Result.failure('Bir hata oluştu: $e');
    }
  }
}
