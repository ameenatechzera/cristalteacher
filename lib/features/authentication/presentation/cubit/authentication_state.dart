part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final LoginEntity loginEntity;

  const AuthenticationSuccess(this.loginEntity);
}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  const AuthenticationFailure(this.message);
}

class FetchSchoolLoading extends AuthenticationState {}

class FetchSchoolSuccess extends AuthenticationState {
  final FetchSchoolEntity response;

  const FetchSchoolSuccess(this.response);
}

class FetchSchoolFailure extends AuthenticationState {
  final String message;

  const FetchSchoolFailure(this.message);
}

class GetBranchLoading extends AuthenticationState {}

class GetBranchSuccess extends AuthenticationState {
  final GetBranchEntity response;

  const GetBranchSuccess(this.response);
}

class GetBranchFailure extends AuthenticationState {
  final String message;

  const GetBranchFailure(this.message);
}

class FetchTutorshipClassLoading extends AuthenticationState {
  const FetchTutorshipClassLoading();
}

class FetchTutorshipClassSuccess extends AuthenticationState {
  final FetchTutorshipClassEntity response;

  const FetchTutorshipClassSuccess(this.response);
}

class FetchTutorshipClassFailure extends AuthenticationState {
  final String message;

  const FetchTutorshipClassFailure(this.message);
}

class FetchAccYearLoading extends AuthenticationState {}

class FetchAccYearSuccess extends AuthenticationState {
  final FetchAccYearEntity response;

  const FetchAccYearSuccess(this.response);
}

class FetchAccYearFailure extends AuthenticationState {
  final String message;

  const FetchAccYearFailure(this.message);
}
