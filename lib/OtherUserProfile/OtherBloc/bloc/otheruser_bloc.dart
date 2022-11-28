import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'otheruser_event.dart';
part 'otheruser_state.dart';

class OtheruserBloc extends Bloc<OtheruserEvent, OtheruserState> {
  OtheruserBloc() : super(OtheruserInitial()) {
    on<OhterUserLoadingEvent>((event, emit) {
      emit(OtheruserLoadingState());
    });
    on<OhterUserFetchEvent>((event, emit) {
      emit(OtheruserFetchState());
    });
  }
}
