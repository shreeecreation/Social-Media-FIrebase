part of 'otheruser_bloc.dart';

abstract class OtheruserEvent extends Equatable {
  const OtheruserEvent();

  @override
  List<Object> get props => [];
}

class OhterUserLoadingEvent extends OtheruserEvent {}

class OhterUserFetchEvent extends OtheruserEvent {}
