import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_sample/bloc/data/model/account_details.dart';
import 'package:flutter_bloc_sample/bloc/data/model/card_model.dart';
import 'package:flutter_bloc_sample/common/config.dart';
import 'package:http/http.dart' as http;

class CardProvider{

  /// Fetch the user details from given public URL
  Future<AccountCard> addCard(
      {required String name,required  String cardNo,required  String validity,required  String cvv}) async {
    final response = await http.post(
      Uri.parse("${Config.BASE_URL}/cards/"),
      headers: {'Authorization': 'token ${Config.token}'},
      body: {
        "name": name,
        "card_no": cardNo,
        "validity": validity,
        "cvv": cvv,
      },
    );

    if (response.statusCode == 200) {
      final resData = jsonDecode(response.body);
      debugPrint("Response: " + resData.toString());
      if (resData['status'] == 200) {
        return AccountCard.fromMap(resData['data']);
      }else if(resData['status'] == 400 && resData['error']['card_no'] != null){
        throw Exception(resData['error']['card_no']);
      }else{
        throw Exception("Please enter correct input.");
      }
    }
    throw Exception('Not able to fetch the data: ' + response.body);
  }

  Future<void> deleteCard({required AccountCard accountCard}) async {
    final response = await http.delete(
      Uri.parse("${Config.BASE_URL}/cards/${accountCard.id}/"),
      headers: {'Authorization': 'token ${Config.token}'},
    );
    if (response.statusCode == 200) {
      final resData = jsonDecode(response.body);
      debugPrint("Response: " + resData.toString());
      if (resData['status'] == 200) {
        return;
      }else if(resData['status'] == 400){
        throw Exception("Invalid Card");
      }else{
        throw Exception("Please enter correct input.");
      }
    }
    throw Exception('Not able to fetch the data: ' + response.body);
  }


}
