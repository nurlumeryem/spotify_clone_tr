class Song {
  final int id;
  final String title;
  final String artist;
  final String filePath;
  final String url;
  final String userId;
  final DateTime createdAt;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.filePath,
    required this.url,
    required this.userId,
    required this.createdAt,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      filePath: json['file_path'],
      url: json['url'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
