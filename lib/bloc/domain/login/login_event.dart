part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String phone;
  final String password;

  LoginButtonPressed({required this.phone, required this.password});
}

class LogoutButtonPressed extends LoginEvent {}
