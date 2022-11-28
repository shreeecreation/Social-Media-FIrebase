part of 'otheruser_bloc.dart';

abstract class OtheruserState extends Equatable {
  const OtheruserState();

  @override
  List<Object> get props => [];
}

class OtheruserInitial extends OtheruserState {}

class OtheruserLoadingState extends OtheruserState {}

class OtheruserFetchState extends OtheruserState {}
