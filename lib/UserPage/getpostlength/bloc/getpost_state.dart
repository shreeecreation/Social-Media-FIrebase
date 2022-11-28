part of 'getpost_bloc.dart';

abstract class GetpostState extends Equatable {
  const GetpostState();

  @override
  List<Object> get props => [];
}

class GetpostInitial extends GetpostState {}

class GetPostLoadingState extends GetpostState {}

class GetPostFetchState extends GetpostState {}
