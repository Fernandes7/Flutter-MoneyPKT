import 'package:hive/hive.dart';
import 'package:moneypt/models/Transaction/transactionmodel.dart';

const transactionDbname = "transaction-db";

abstract class TranscationDbfunctions {
  Future<void> addTransaction(TransactionModel obj);
}

class TransactionDB implements TranscationDbfunctions {
  TransactionDB.insatnces();
  static TransactionDB instances = TransactionDB.insatnces();
  factory TransactionDB() {
    return instances; 
  }
  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(transactionDbname);
    await db.put(obj.id, obj);
  }
}
