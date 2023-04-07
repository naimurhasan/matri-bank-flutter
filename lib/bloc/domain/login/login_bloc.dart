import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/bloc/data/model/account_details.dart';
import 'package:flutter_bloc_sample/bloc/data/repository/login_details_repository.dart';
import 'package:flutter_bloc_sample/common/config.dart';

part 'login_state.dart';
part 'login_event.dart';

class AccountBloc extends Bloc<LoginEvent, LoginState> {
  AccountBloc() : super(InitialLoginState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield SubmittingLogin();
      try {
        LoginDetailsRepository loginDetailsRepository =
            LoginDetailsRepository();
        Config.token = await loginDetailsRepository.login(event.phone, event.password);
        AccountDetails accountDetails =
            await loginDetailsRepository.getAccountDetails();

        yield LoginSuccess(accountDetails);
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text("Login Success"), backgroundColor: Colors.green,));
      } on SocketException catch(e, trace){
        yield LoginError(message: "No Internet Connection", phone: event.phone, password: event.password);
        debugPrintStack(stackTrace: trace);
      }catch (e, trace) {
        print("Exception while fetching user details: " + e.toString());
        yield LoginError(message: e.toString(), phone: event.phone, password: event.password);
        debugPrintStack(stackTrace: trace);
      }
    }else if(event is LogoutButtonPressed){
      Config.token = "";
      yield InitialLoginState();
    }else if(event is UpdateAccountDetails){
      yield LoginSuccess(event.accountDetails);
    }
  }
}
