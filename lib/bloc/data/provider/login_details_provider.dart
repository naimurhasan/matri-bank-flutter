import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_sample/bloc/data/model/account_details.dart';
import 'package:http/http.dart' as http;

class LoginDetailsProvider {
  final String BASE = "http://naimurhasan.pythonanywhere.com";

  /// Fetch the user details from given public URL
  Future<String> login(String phone, String password) async {
    final response = await http.post(
      Uri.parse("$BASE/accounts/login/"),
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

  Future<AccountDetails> getAccountDetails(String token) async {
    final response = await http.get(Uri.parse("$BASE/accounts/"),
        headers: {'Authorization': 'token $token'});

    if (response.statusCode == 200) {
      final resData = jsonDecode(response.body);
      return AccountDetails.fromMap(resData['data']);
    }
    throw Exception('Not able to fetch the data: ' + response.body);
  }
}
