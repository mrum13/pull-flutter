part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final List<DataListUser> dataListUser;

  UserSuccess(this.dataListUser);

  @override
  // TODO: implement props
  List<Object> get props => [dataListUser];
}

class UserFailed extends UserState {
  final String error;

  UserFailed(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error];
}

