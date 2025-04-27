class Song {
  final int id;
  final String title;
  final String artist;

  Song({required this.id, required this.title, required this.artist});

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(id: json['id'], title: json['title'], artist: json['artist']);
  }
}
