import 'package:flutter_bloc_sample/bloc/data/model/account_details.dart';
import 'package:flutter_bloc_sample/bloc/data/provider/login_details_provider.dart';

class LoginDetailsRepository {
  final LoginDetailsProvider _loginDetailsProvider = LoginDetailsProvider();

  // Fetch the api response and pass it to bloc component
  Future<String> login(String phone, String password) async =>
      _loginDetailsProvider.login(phone, password);

  Future<AccountDetails> getAccountDetails() async =>
      _loginDetailsProvider.getAccountDetails();
}
