import 'package:flutter_bloc_sample/bloc/data/model/card_model.dart';
import 'package:flutter_bloc_sample/bloc/data/provider/account_details_provider.dart';

class CardRepository {
  final CardProvider cardProvider = CardProvider();

  Future<AccountCard> addCard({required String name,required  String cardNo,required  String validity,required  String cvv}) async =>
      cardProvider.addCard(name: name, cardNo: cardNo, validity: validity, cvv: cvv);
}