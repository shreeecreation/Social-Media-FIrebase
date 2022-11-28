import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<Postfetchevent>((event, emit) {
      emit(Postloading());
    });
    on<PostFetched>((event, emit) {
      emit(PostFetch());
    });
  }
}
