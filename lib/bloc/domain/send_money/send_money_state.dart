part of 'send_money_bloc.dart';

@immutable
abstract class SendMoneyState {}

class InitialSendMoneyState extends SendMoneyState {}

class SubmittingSendMoney extends SendMoneyState {}

class SendMoneySuccess extends SendMoneyState {
  final Transaction transaction;
  SendMoneySuccess({required this.transaction});
}

class SendMoneyFailure extends SendMoneyState {
  final String error;
  final double? amount;
  final String? destination;
  SendMoneyFailure({this.error = "Something went wrong", this.amount, this.destination, });
}