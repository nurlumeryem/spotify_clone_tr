import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_clone_tr/domain/entities/song/song.dart';

class SongModel {
  String? title;
  String? artist;
  num? duration;
  Timestamp? releaseDate;
  String? coverFileName;
  bool? isFavorite;
  String? songId;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.isFavorite,
    required this.songId,
    required this.coverFileName,
  });

  SongModel.fromJson(Map<String, dynamic> data) {
    title = data['title'] as String?;
    artist = data['artist'] as String?;
    duration = data['duration'] as num?;

    if (data['created_at'] != null && data['created_at'] is String) {
      try {
        releaseDate = Timestamp.fromDate(
          DateTime.parse(data['created_at'] as String),
        );
      } catch (e) {
        print(
          'Error parsing created_at to Timestamp: $e. Value: ${data['created_at']}',
        );
        releaseDate = null;
      }
    } else {
      releaseDate = null;
    }

    coverFileName = data['file_path'] as String?;
    isFavorite = false;
    songId = data['id']?.toString();
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title ?? 'Unknown Title',
      artist: artist ?? 'Unknown Artist',
      duration: duration ?? 0,
      releaseDate: releaseDate ?? Timestamp.now(),
      isFavorite: isFavorite ?? false,
      songId: songId ?? '',
      coverFileName: coverFileName ?? '',
    );
  }
}
