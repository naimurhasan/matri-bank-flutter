import 'dart:async';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/bloc/data/model/PostTransaction.dart';
import 'package:flutter_bloc_sample/bloc/data/model/Transaction.dart';
import 'package:flutter_bloc_sample/bloc/data/repository/transaction_repository.dart';

part 'send_money_state.dart';
part 'send_money_event.dart';

class SendMoneyBloc extends Bloc<SendMoneyEvent, SendMoneyState>{
  SendMoneyBloc() : super(InitialSendMoneyState());

  @override
  Stream<SendMoneyState> mapEventToState(SendMoneyEvent event) async*{
    if(event is SendMoneyButtonPressed){
      yield SubmittingSendMoney();
      try{
        TransactionRepository transactionRepository = TransactionRepository();
        Transaction transaction = await transactionRepository.sendMoney(PostTransaction(amount: event.amount, destination: event.destination));
        yield SendMoneySuccess(transaction: transaction);
        Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          message: "Money Sent",
          duration: Duration(seconds: 2),
        )..show(event.context);
      } on SocketException catch(e, trace){
        yield SendMoneyFailure(error: "No Internet Connection", amount: event.amount, destination: event.destination);
        debugPrintStack(stackTrace: trace);
      }catch(e, trace){
        print("Exception while fetching user details: " + e.toString());
        yield SendMoneyFailure(error: e.toString(), amount: event.amount, destination: event.destination);
        debugPrintStack(stackTrace: trace);
      }
    }
  }

}
