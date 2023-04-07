part of 'card_bloc.dart';

@immutable
abstract class CardEvent {
  const CardEvent();
}

class AddNewCardEvent extends CardEvent {
  final String name;
  final String cardNo;
  final String validity;
  final String cvv;
  final BuildContext context;
  AddNewCardEvent(
      {required this.name,
        required this.cardNo,
        required this.validity,
        required this.cvv,
        required this.context});
}