part of 'get_post_public_bloc.dart';

abstract class GetPostPublicEvent extends Equatable {
  const GetPostPublicEvent();

  @override
  List<Object> get props => [];
}

class GetPostPublicLoadingEvent extends GetPostPublicEvent {}

class GetPostPublicFetchEvent extends GetPostPublicEvent {}
