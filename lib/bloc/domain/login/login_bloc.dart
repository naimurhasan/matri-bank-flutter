import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_sample/bloc/data/model/account_details.dart';
import 'package:flutter_bloc_sample/bloc/data/repository/login_details_repository.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLoginState());
  String? token;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield SubmittingLogin();
      try {
        LoginDetailsRepository loginDetailsRepository =
            LoginDetailsRepository();
        token = await loginDetailsRepository.login(event.phone, event.password);
        if (token == null) {
          throw Exception("Token is null");
        }
        AccountDetails accountDetails =
            await loginDetailsRepository.getAccountDetails(token!);

        yield LoginSuccess(accountDetails);
      } on SocketException catch(e, trace){
        yield LoginError(message: "No Internet Connection", phone: event.phone, password: event.password);
        debugPrintStack(stackTrace: trace);
      }catch (e, trace) {
        print("Exception while fetching user details: " + e.toString());
        yield LoginError(message: e.toString(), phone: event.phone, password: event.password);
        debugPrintStack(stackTrace: trace);
      }
    }else if(event is LogoutButtonPressed){
      token = null;
      yield InitialLoginState();
    }
  }
}
