part of 'card_bloc.dart';

@immutable
abstract class CardState {
  const CardState();
}

class InitialCardState extends CardState {
  const InitialCardState();
}

class AddingNewCard extends CardState {
  const AddingNewCard();
}

class CardAddError extends CardState {
  final String message;
  final String? name;
  final String? cardNo;
  final String? validity;
  final String? cvv;

  const CardAddError({
    this.message = "Error Adding New Card",
    this.name,
    this.cardNo,
    this.validity,
    this.cvv,
  });
}

class CardAdded extends CardState {
  final AccountCard accountCard;
  const CardAdded({required this.accountCard});
}

class CardDeleting extends CardState {
  const CardDeleting();
}

class CardDeleteError extends CardState {
  final String message;
  const CardDeleteError({this.message = "Error Deleting Card"});
}

class CardDeleted extends CardState {
  final AccountCard accountCard;
  const CardDeleted(this.accountCard);
}