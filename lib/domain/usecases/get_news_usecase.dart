import 'package:spotify_clone_tr/core/usecase/usecase.dart';
import 'package:spotify_clone_tr/core/utils/result.dart';
import 'package:spotify_clone_tr/data/repositories/songs_repository_impl.dart';

import 'package:spotify_clone_tr/service_locator.dart';

class GetNewsSongsUsecase implements UseCase<Result, dynamic> {
  @override
  Future<Result<void>> call({params}) async {
    return await sl<SongRepositoryImpl>().getNewsSongs();
  }
}
