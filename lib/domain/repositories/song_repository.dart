import 'package:spotify_clone_tr/core/utils/result.dart';

abstract class SongRepository {
  Future<Result> getNewsSongs();
}
