// ignore_for_file: must_be_immutable

part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class PostFetch extends PostState {
  @override
  List<Object> get props => [];
}

class Postloading extends PostState {
  @override
  List<Object> get props => [];
}
