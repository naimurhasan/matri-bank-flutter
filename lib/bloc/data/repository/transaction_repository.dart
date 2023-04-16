
import 'package:flutter_bloc_sample/bloc/data/model/PostTransaction.dart';
import 'package:flutter_bloc_sample/bloc/data/provider/transacrion_provider.dart';
import '../model/Transaction.dart';

class TransactionRepository {
  final TransactionProvider _transactionProvider = TransactionProvider();

  // Fetch the api response and pass it to bloc component
  Future<Transaction> sendMoney(PostTransaction transaction) async =>
      _transactionProvider.sendMoney(transaction);

  Future<Transaction> static(PostTransaction transaction) async =>
      _transactionProvider.sendMoney(transaction);
}
