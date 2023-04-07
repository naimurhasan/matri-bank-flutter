part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String phone;
  final String password;
  final BuildContext context;

  LoginButtonPressed({required this.phone, required this.password, required this.context});
}

class LogoutButtonPressed extends LoginEvent {}

class UpdateAccountDetails extends LoginEvent {
  final AccountDetails accountDetails;
  UpdateAccountDetails({required this.accountDetails});
}
