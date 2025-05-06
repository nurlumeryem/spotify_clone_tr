import 'package:equatable/equatable.dart';

abstract class PlayListEvent extends Equatable {
  const PlayListEvent();

  @override
  List<Object> get props => [];
}

class FetchPlayList extends PlayListEvent {}
