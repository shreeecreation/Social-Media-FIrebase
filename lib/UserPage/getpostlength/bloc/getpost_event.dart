part of 'getpost_bloc.dart';

abstract class GetpostEvent extends Equatable {
  const GetpostEvent();

  @override
  List<Object> get props => [];
}

class GetPostLoadingEvent extends GetpostEvent {}

class GetPostFetchEvent extends GetpostEvent {}
