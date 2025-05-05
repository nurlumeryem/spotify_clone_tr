class AppURLs {
  static const coverStorage =
      'https://xuqaqmcpmdrcomrhzzdy.supabase.co/storage/v1/object/public/covers-public/';

  static const defaultImage =
      'https://cdn-icons-png.flaticon.com/512/10542/10542486.png';

  /// Supabase’dan gelen tam signed URL’den dosya adını alıp
  /// public bucket prefix’i ile birleştirir.
  static String coverFromFullPath(String? fullPath) {
    if (fullPath == null) return defaultImage;
    // URL’in son segmentini (file?token=…) al, sonra query’i at
    final fileName =
        fullPath
            .split('/')
            .last // "tarkan_kuzu_kuzu.JPG?token=…"
            .split('?')
            .first; // "tarkan_kuzu_kuzu.JPG"
    return '$coverStorage$fileName';
  }
}
