import 'package:flutter_bloc_sample/bloc/data/model/card_model.dart';
import 'package:flutter_bloc_sample/bloc/data/provider/card_providier.dart';

class CardRepository {
  final CardProvider cardProvider = CardProvider();

  Future<AccountCard> addCard({required String name,required  String cardNo,required  String validity,required  String cvv}) async =>
      cardProvider.addCard(name: name, cardNo: cardNo, validity: validity, cvv: cvv);
  Future<void> deleteCard({required AccountCard accountCard}) async =>
      cardProvider.deleteCard(accountCard: accountCard);
  Future<void> updateCard({required AccountCard accountCard}) async =>
      cardProvider.updateCard(accountCard: accountCard);
}