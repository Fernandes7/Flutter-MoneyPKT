import 'package:hive_flutter/hive_flutter.dart';
import '../Category/categorymodel.dart';
part 'transactionmodel.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final String purpose;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final CategoryType type;

  @HiveField(4)
  final Categorymodel category;

  @HiveField(5)
  String? id;

  TransactionModel(
      {required this.purpose,
      required this.amount,
      required this.date,
      required this.type,
      required this.category}) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
