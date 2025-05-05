import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_urls.dart';
import 'package:spotify_clone_tr/domain/entities/song/song.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/news_songs_bloc.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/news_songs_event.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify_clone_tr/service_locator.dart';
import 'package:spotify_clone_tr/domain/usecases/get_news_usecase.dart';

class NewSongs extends StatelessWidget {
  const NewSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              NewsSongsBloc(sl<GetNewsSongsUseCase>())..add(FetchNewsSongs()),

      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsBloc, NewsSongsState>(
          builder: (context, state) {
            if (state is NewsSongsLoading) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
            if (state is NewsSongsLoaded) {
              print('Gelen şarkı sayısı: ${state.songs.length}');
              return _songs(state.songs);
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final song = songs[index];

        return SizedBox(
          width: 160,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.hardEdge,

                  child: Image.network(
                    // song.coverFileName burada hâlâ fullPath; helper bunu dönüştürecek
                    AppURLs.coverFromFullPath(song.coverFileName),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        AppURLs.defaultImage,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                song.title,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 14),
      itemCount: songs.length,
    );
  }
}
