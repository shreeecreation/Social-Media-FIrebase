part of 'get_post_public_bloc.dart';

abstract class GetPostPublicState extends Equatable {
  const GetPostPublicState();

  @override
  List<Object> get props => [];
}

class GetPostPublicInitial extends GetPostPublicState {}

class GetPostPublicLoadingState extends GetPostPublicState {}

class GetPostPublicFetchState extends GetPostPublicState {}
