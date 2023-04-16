part of 'send_money_bloc.dart';

@immutable
abstract class SendMoneyEvent {}

class SendMoneyButtonPressed extends SendMoneyEvent {
  final BuildContext context;
  final double amount;
  final String destination;

  SendMoneyButtonPressed(
      {required this.context, required this.amount, required this.destination});
}
