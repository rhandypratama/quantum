import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthState {}

class UnAuthenticated extends AuthState {}

class Authenticated extends AuthState {
  final String token;

  const Authenticated({required this.token});

}

class AuthenticationFailure extends AuthState {
  final String message;

  const AuthenticationFailure({required this.message});

  @override
  List<Object> get props => [message];
}