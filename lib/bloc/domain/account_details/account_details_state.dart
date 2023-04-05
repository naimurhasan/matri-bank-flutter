part of 'account_details_bloc.dart';

@immutable
abstract class AccountDetailsState {
  const AccountDetailsState();
}

class InitialAccountDetailsState extends AccountDetailsState {
  const InitialAccountDetailsState();
}

class LoadedAccountDetailsState extends AccountDetailsState {
  final AccountDetails accountDetails;
  const LoadedAccountDetailsState(this.accountDetails);
}