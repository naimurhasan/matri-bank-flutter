part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class InitialLoginState extends LoginState {}

class SubmittingLogin extends LoginState {}

class LoginSuccess extends LoginState {
  final AccountDetails accountDetails;
  LoginSuccess(this.accountDetails);
}

class LoginError extends LoginState {
  final String message;
  final String? phone, password;
  LoginError({this.message = "Login Error", this.phone, this.password,});
}
