import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_sample/bloc/data/model/account_details.dart';
import 'package:flutter_bloc_sample/common/config.dart';
import 'package:http/http.dart' as http;

class LoginDetailsProvider {

  /// Fetch the user details from given public URL
  Future<String> login(String phone, String password) async {
    final response = await http.post(
      Uri.parse("${Config.BASE_URL}/accounts/login/"),
      body: {
        "phone": phone,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      final resData = jsonDecode(response.body);
      if(resData['data']['token'] == null)
        throw Exception('Password/Phone combination error.');
      return resData['data']['token'];
    }
    throw Exception('Not able to fetch the data: ' + response.body);
  }

  Future<AccountDetails> getAccountDetails() async {
    final response = await http.get(Uri.parse("${Config.BASE_URL}/accounts/"),
        headers: {'Authorization': 'token ${Config.token}'});

    if (response.statusCode == 200) {
      final resData = jsonDecode(response.body);
      return AccountDetails.fromMap(resData['data']);
    }
    throw Exception('Not able to fetch the data: ' + response.body);
  }
}
