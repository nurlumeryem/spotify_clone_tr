import 'package:get_it/get_it.dart';
import 'package:spotify_clone_tr/core/configs/router/app_router.dart';
import 'package:spotify_clone_tr/data/repositories/auth_repository_impl.dart';
import 'package:spotify_clone_tr/data/repositories/songs_repository_impl.dart';
import 'package:spotify_clone_tr/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify_clone_tr/data/sources/song/song_supabase_service.dart';
import 'package:spotify_clone_tr/domain/repositories/auth_repository.dart';
import 'package:spotify_clone_tr/domain/repositories/song_repository.dart';
import 'package:spotify_clone_tr/domain/usecases/add_or_remove_favorite_usecase.dart';
import 'package:spotify_clone_tr/domain/usecases/get_news_usecase.dart';
import 'package:spotify_clone_tr/domain/usecases/get_play_list._usecase.dart';
import 'package:spotify_clone_tr/domain/usecases/is_favorite_song_usecase.dart';
import 'package:spotify_clone_tr/domain/usecases/signin_usecase.dart';
import 'package:spotify_clone_tr/domain/usecases/signup_usecase.dart';
import 'package:spotify_clone_tr/service/music_service.dart';
import 'package:supabase/supabase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // SupabaseClient'ı manuel oluştur ve kaydet
  sl.registerSingleton<SupabaseClient>(
    SupabaseClient(
      dotenv.env['SUPABASE_URL']!,
      dotenv.env['SUPABASE_ANON_KEY']!,
    ),
  );

  // Auth servisi
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<SongSupabaseService>(
    SongSupabaseServiceImpl(sl<SupabaseClient>()),
  );

  sl.registerSingleton<AppRouter>(AppRouter());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SongRepository>(SongRepositoryImpl());

  sl.registerSingleton<SignupUseCase>(SignupUseCase(sl<AuthRepository>()));
  sl.registerSingleton<SigninUseCase>(SigninUseCase());

  // Music service, artık SupabaseClient'e bağımlı olacak
  sl.registerSingleton<SupabaseMusicService>(SupabaseMusicService(sl()));

  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());
  sl.registerSingleton<GetPlayListUseCase>(GetPlayListUseCase());
  sl.registerSingleton<IsFavoriteSongUsecase>(IsFavoriteSongUsecase());
  sl.registerSingleton<AddOrRemoveFavoriteUsecase>(
    AddOrRemoveFavoriteUsecase(),
  );
}
