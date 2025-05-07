import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorite_button_event.dart';
part 'favorite_button_state.dart';

class FavoriteButtonBloc extends Bloc<FavoriteButtonEvent, FavoriteButtonState> {
  FavoriteButtonBloc() : super(FavoriteButtonInitial()) {
    on<FavoriteButtonEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
