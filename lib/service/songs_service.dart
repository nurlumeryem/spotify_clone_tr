import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:spotify_clone_tr/data/models/song/song.dart';

class SongsService {
  static const String baseUrl = 'http://10.0.2.2:3000';

  Future<List<Song>> fetchSongs() async {
    final response = await http.get(Uri.parse('$baseUrl/songs'));

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((song) => Song.fromJson(song)).toList();
    } else {
      throw Exception('Şarkılar yüklenemedi: ${response.statusCode}');
    }
  }
}
