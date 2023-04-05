import 'dart:convert';

import 'package:flutter_bloc_sample/bloc/data/model/card_model.dart';

AccountDetails accountDetailsFromMap(String str) =>
    AccountDetails.fromMap(json.decode(str));

String accountDetailsToMap(AccountDetails data) => json.encode(data.toMap());

class AccountDetails {
  AccountDetails({
    required this.id,
    required this.name,
    required this.phone,
    required this.balance,
    required this.lastLogin,
    required this.createdAt,
    required this.updatedAt,
    required this.balanceLastUpdate,
    this.photo,
    required this.cards,
  });

  final int id;
  final String name;
  final String phone;
  final double balance;
  final DateTime lastLogin;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime balanceLastUpdate;
  final String? photo;
  final List<AccountCard> cards;

  AccountDetails copyWith({
    int? id,
    String? name,
    String? phone,
    double? balance,
    DateTime? lastLogin,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? balanceLastUpdate,
    String? photo,
    List<AccountCard>? card,
  }) =>
      AccountDetails(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        balance: balance ?? this.balance,
        lastLogin: lastLogin ?? this.lastLogin,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        balanceLastUpdate: balanceLastUpdate ?? this.balanceLastUpdate,
        photo: photo ?? this.photo,
        cards: card ?? this.cards,
      );

  factory AccountDetails.fromMap(Map<String, dynamic> json) => AccountDetails(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        balance: json["balance"],
        lastLogin: DateTime.parse(json["last_login"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        balanceLastUpdate: DateTime.parse(json["balance_last_update"]),
        photo: json["photo"],
        cards: cardsFromMap(json['cards']),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "phone": phone,
        "balance": balance,
        "last_login": lastLogin.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "balance_last_update": balanceLastUpdate.toIso8601String(),
        "photo": photo,
      };
}
