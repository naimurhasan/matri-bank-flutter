part of 'account_details_bloc.dart';

@immutable
abstract class AccountDetailsEvent {
  const AccountDetailsEvent();
}

class AccountDetailsLoaded extends AccountDetailsEvent {
  final AccountDetails accountDetails;
  AccountDetailsLoaded({required this.accountDetails});
}