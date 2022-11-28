import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'getpost_event.dart';
part 'getpost_state.dart';

class GetpostBloc extends Bloc<GetpostEvent, GetpostState> {
  GetpostBloc() : super(GetpostInitial()) {
    on<GetPostLoadingEvent>((event, emit) {
      emit(GetPostLoadingState());
    });
    on<GetPostFetchEvent>((event, emit) {
      emit(GetPostFetchState());
    });
  }
}
