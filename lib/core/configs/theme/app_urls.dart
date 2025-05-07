class AppURLs {
  static const coverStorage =
      'https://xuqaqmcpmdrcomrhzzdy.supabase.co/storage/v1/object/public/covers-public/';

  static const songStorage =
      'https://xuqaqmcpmdrcomrhzzdy.supabase.co/storage/v1/object/public/songs-public/';

  static const defaultImage =
      'https://cdn-icons-png.flaticon.com/512/10542/10542486.png';

  static String songUrl(String artist, String title) {
    final filename =
        '${artist.toLowerCase()}_${title.toLowerCase()}'
            .replaceAll(' ', '_')
            .replaceAll(RegExp(r'[^a-z0-9_]'), '') +
        '.mp3';
    print(AppURLs.songUrl(artist, title));
    return '$songStorage$filename';
  }
}
