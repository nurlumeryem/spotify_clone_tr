import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_tr/domain/entities/song/song.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/news_songs_bloc.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify_clone_tr/service_locator.dart';
import 'package:spotify_clone_tr/domain/usecases/get_news_usecase.dart';

class NewSongs extends StatelessWidget {
  const NewSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsBloc(sl<GetNewsSongsUseCase>()),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsBloc, NewsSongsState>(
          builder: (context, state) {
            if (state is NewsSongsLoading) {
              return CircularProgressIndicator();
            }
            if (state is NewsSongsLoaded) {
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
        return Column();
      },
      separatorBuilder: (context, index) => SizedBox(width: 14),
      itemCount: songs.length,
    );
  }
}
