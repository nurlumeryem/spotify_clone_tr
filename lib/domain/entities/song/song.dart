import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String title;
  final String artist;
  final String url;
  final num duration;
  final Timestamp releaseDate;
  final bool isFavorite;
  final String songId;
  final String coverFileName;
  final String id;

  SongEntity({
    required this.title,
    required this.artist,
    required this.url,
    required this.duration,
    required this.releaseDate,
    required this.isFavorite,
    required this.songId,
    required this.coverFileName,
    required this.id,
  });

  // Convert a SongEntity to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'coverFileName': coverFileName,
      'url': url,
    };
  }

  // Create a SongEntity from a Map
  factory SongEntity.fromMap(Map<String, dynamic> map) {
    return SongEntity(
      id: map['id'],
      title: map['title'],
      artist: map['artist'],
      coverFileName: map['coverFileName'],
      url: map['url'],
      duration: map['duration'],
      releaseDate: map['releaseDate'],
      isFavorite: map['isFavorite'],
      songId: map['songId'],
    );
  }
}
