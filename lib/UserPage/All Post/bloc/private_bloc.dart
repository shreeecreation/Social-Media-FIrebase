import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'private_event.dart';
part 'private_state.dart';

class PrivateBloc extends Bloc<PrivateEvent, PrivateState> {
  PrivateBloc() : super(PrivateInitial()) {
    on<PostLoadingPrivate>((event, emit) {
      emit(PostLoadinState());
    });
    on<PostFetchedEvent>((event, emit) {
      emit(PostfetchState());
    });
  }
}
