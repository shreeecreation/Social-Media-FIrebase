import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_post_public_event.dart';
part 'get_post_public_state.dart';

class GetPostPublicBloc extends Bloc<GetPostPublicEvent, GetPostPublicState> {
  GetPostPublicBloc() : super(GetPostPublicInitial()) {
    on<GetPostPublicLoadingEvent>((event, emit) {
      emit(GetPostPublicLoadingState());
    });
    on<GetPostPublicFetchEvent>((event, emit) {
      emit(GetPostPublicFetchState());
    });
  }
}
