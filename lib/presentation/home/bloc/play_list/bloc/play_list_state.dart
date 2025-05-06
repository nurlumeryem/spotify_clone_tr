import 'package:equatable/equatable.dart';
import 'package:spotify_clone_tr/domain/entities/song/song.dart';

abstract class PlayListState extends Equatable {
  const PlayListState();

  @override
  List<Object> get props => [];
}

class PlayListInitial extends PlayListState {}

class PlayListLoading extends PlayListState {}

class PlayListLoaded extends PlayListState {
  final List<SongEntity> songs;

  const PlayListLoaded(this.songs);

  @override
  List<Object> get props => [songs];
}

class PlayListLoadFailure extends PlayListState {
  final String message;

  const PlayListLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}
