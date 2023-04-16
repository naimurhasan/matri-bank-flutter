class Transaction {
  Transaction({
    required this.id,
    required this.source,
    required this.destination,
    required this.type,
    required this.amount,
    required this.additional,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(dynamic json) => Transaction(
    id : json['id'],
    source : json['source'],
    destination : json['destination'],
    type : json['type'],
    amount : json['amount'],
    additional : json['additional'],
    createdAt : json['created_at'],
    updatedAt : json['updated_at']
  );

  int id;
  int source;
  int destination;
  String type;
  double amount;
  String additional;
  String createdAt;
  String updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['source'] = source;
    map['destination'] = destination;
    map['type'] = type;
    map['amount'] = amount;
    map['additional'] = additional;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
