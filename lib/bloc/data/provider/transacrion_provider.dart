import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_sample/bloc/data/model/PostTransaction.dart';
import 'package:flutter_bloc_sample/bloc/data/model/Transaction.dart';
import 'package:flutter_bloc_sample/bloc/data/model/account_details.dart';
import 'package:flutter_bloc_sample/common/config.dart';
import 'package:http/http.dart' as http;

class TransactionProvider {

  /// Fetch the user details from given public URL
  Future<Transaction> sendMoney(PostTransaction transaction) async {
    final response = await http.post(
      Uri.parse("${Config.BASE_URL}/transaction/do/send-money/"),
      headers: {'Authorization': 'token ${Config.token}'},
      body: transaction.toJson(),
    );

    if (response.statusCode == 200) {
      final resData = jsonDecode(response.body);
      if(resData['status']==200){
        return Transaction.fromJson(resData['data']);
      }else if(resData['status']==400){
        throw Exception(resData['error'].toString());
      }

    }
    throw Exception('Not able to fetch the data: ' + response.body);
  }

  Future<List<Transaction>> getTransactions() async {
    final response = await http.get(Uri.parse("${Config.BASE_URL}/transaction/"),
        headers: {'Authorization': 'token ${Config.token}'});

    if (response.statusCode == 200) {
      final resData = jsonDecode(response.body);
      return List<Transaction>.from(resData['data'].map((x) => Transaction.fromJson(x)));
    }
    throw Exception('Not able to fetch the data: ' + response.body);
  }
}
