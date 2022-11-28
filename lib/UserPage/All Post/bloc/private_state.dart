part of 'private_bloc.dart';

abstract class PrivateState extends Equatable {
  const PrivateState();

  @override
  List<Object> get props => [];
}

class PrivateInitial extends PrivateState {}

class PostLoadinState extends PrivateState {}

class PostfetchState extends PrivateState {}
