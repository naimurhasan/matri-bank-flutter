import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/bloc/data/model/account_details.dart';
import 'package:meta/meta.dart';

part 'account_details_event.dart';
part 'account_details_state.dart';

class AccountDetailsBloc extends Bloc<AccountDetailsEvent, AccountDetailsState> {
  AccountDetailsBloc() : super(InitialAccountDetailsState());

  @override
  Stream<AccountDetailsState> mapEventToState(
    AccountDetailsEvent event,
  ) async* {
    if (event is AccountDetailsLoaded) {
      yield LoadedAccountDetailsState(event.accountDetails);
    }
  }
}