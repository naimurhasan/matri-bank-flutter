List<AccountCard> cardsFromMap(dynamic data) => List<AccountCard>.from(data.map((x) => AccountCard.fromMap(x)));

class AccountCard {
  AccountCard({
    required this.id,
    required this.name,
    required this.cardNo,
    required this.validity,
    required this.cvv,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final String cardNo;
  final String validity;
  final String cvv;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  AccountCard copyWith({
    int? id,
    String? name,
    String? cardNo,
    String? validity,
    String? cvv,
    int? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      AccountCard(
        id: id ?? this.id,
        name: name ?? this.name,
        cardNo: cardNo ?? this.cardNo,
        validity: validity ?? this.validity,
        cvv: cvv ?? this.cvv,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory AccountCard.fromMap(Map<String, dynamic> json) => AccountCard(
    id: json["id"],
    name: json["name"],
    cardNo: json["card_no"],
    validity: json["validity"],
    cvv: json["cvv"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "card_no": cardNo,
    "validity": validity,
    "cvv": cvv,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}