part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class Postfetchevent extends PostEvent {}

class PostLoading extends PostEvent {}

class PostFetched extends PostEvent {}
