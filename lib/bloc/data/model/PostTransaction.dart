class PostTransaction {
  PostTransaction({
    required this.amount,
    required this.destination,
  });

  double amount;
  String destination;

  factory PostTransaction.fromJson(dynamic json) =>
      PostTransaction(amount: json['amount'], destination: json['destination']);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['destination'] = destination;
    return map;
  }
}
