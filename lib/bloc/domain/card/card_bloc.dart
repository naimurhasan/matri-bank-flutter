import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/bloc/data/model/account_details.dart';
import 'package:flutter_bloc_sample/bloc/data/model/card_model.dart';
import 'package:flutter_bloc_sample/bloc/data/repository/card_repository.dart';
import 'package:flutter_bloc_sample/bloc/domain/login/login_bloc.dart';
import 'package:meta/meta.dart';

part 'card_event.dart';

part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(InitialCardState());

  @override
  Stream<CardState> mapEventToState(
    CardEvent event,
  ) async* {
    if (event is AddNewCardEvent) {
      yield AddingNewCard();
      try {
        CardRepository cardRepository = CardRepository();
        AccountCard card = await cardRepository.addCard(
            name: event.name,
            cardNo: event.cardNo,
            validity: event.validity,
            cvv: event.cvv);
        final userBloc = BlocProvider.of<AccountBloc>(event.context);
        AccountDetails accountDetails =
            (userBloc.state as LoginSuccess).accountDetails;
        accountDetails =
            accountDetails.copyWith(cards: [card, ...accountDetails.cards]);
        userBloc.add(UpdateAccountDetails(accountDetails: accountDetails));
        Navigator.pop(event.context, true);
        yield CardAdded(accountCard: card);
      } on SocketException catch (e, trace) {
        yield CardAddError(
            message: "No Internet Connection",
            name: event.name,
            cardNo: event.cardNo,
            validity: event.validity,
            cvv: event.cvv);

        debugPrintStack(stackTrace: trace);
      } catch (e, trace) {
        print("Exception while fetching user details: " + e.toString());
        yield CardAddError(
            message: e.toString(),
            name: event.name,
            cardNo: event.cardNo,
            validity: event.validity,
            cvv: event.cvv);
        debugPrintStack(stackTrace: trace);
      }
    }else if(event is DeleteCardEvent){
      yield CardDeleting();
      try{
        CardRepository cardRepository = CardRepository();
        await cardRepository.deleteCard(accountCard: event.accountCard);
        final userBloc = BlocProvider.of<AccountBloc>(event.context);
        AccountDetails accountDetails =
        (userBloc.state as LoginSuccess).accountDetails;
        accountDetails =
            accountDetails.copyWith(cards: accountDetails.cards.where((element) => element.id != event.accountCard.id).toList());
        userBloc.add(UpdateAccountDetails(accountDetails: accountDetails));
        yield CardDeleted(event.accountCard);
        Flushbar(
          message: "Card deleted successfully",
          duration: Duration(seconds: 2),
        )..show(event.context);
      } on SocketException catch (e, trace) {
        yield CardDeleteError(message: "No Internet Connection");
        debugPrintStack(stackTrace: trace);
      } catch (e, trace) {
        print("Exception while fetching user details: " + e.toString());
        yield CardDeleteError(message: e.toString());
        debugPrintStack(stackTrace: trace);
      }
    }else if(event is UpdateCardEvent){
      yield CardUpdating();
      try{
        CardRepository cardRepository = CardRepository();
        await cardRepository.updateCard(accountCard: event.accountCard);
        final userBloc = BlocProvider.of<AccountBloc>(event.context);
        AccountDetails accountDetails =
            (userBloc.state as LoginSuccess).accountDetails;
        accountDetails = accountDetails.copyWith(cards: accountDetails.cards.map((e) => e.id == event.accountCard.id ? event.accountCard : e).toList());
        userBloc.add(UpdateAccountDetails(accountDetails: accountDetails));
        yield CardUpdated(accountCard: event.accountCard);
        Navigator.pop(event.context, true);
      } on SocketException catch (e, trace) {
        yield CardDeleteError(message: "No Internet Connection");
        debugPrintStack(stackTrace: trace);
      } catch (e, trace) {
        print("Exception while fetching user details: " + e.toString());
        yield CardDeleteError(message: e.toString());
        debugPrintStack(stackTrace: trace);
      }
    }
  }
}
