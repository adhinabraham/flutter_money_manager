import '../category/category_model.dart';

import 'package:hive_flutter/hive_flutter.dart';
part 'transaction_model.g.dart';



@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final String amount;

  @HiveField(1)
  final String purpose;

  @HiveField(2)
  final DateTime transactionDate;

  @HiveField(3)
  final CategoryType transActionType;

  @HiveField(4)
  final CategoryModel selectedCategory ;

  @HiveField(5)
   String? id;


  TransactionModel( {required this.amount, required this.purpose,required this.transactionDate,required this.transActionType,required this.selectedCategory}) {
    this.id = DateTime
        .now()
        .microsecondsSinceEpoch
        .toString();
  }
}