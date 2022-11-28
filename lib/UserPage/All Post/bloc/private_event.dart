part of 'private_bloc.dart';

abstract class PrivateEvent extends Equatable {
  const PrivateEvent();

  @override
  List<Object> get props => [];
}

class PostLoadingPrivate extends PrivateEvent {}

class PostFetchedEvent extends PrivateEvent {}
