import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/transactions/transaction_model.dart';

const   TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunctions{
  Future <void> addTransaction(TransactionModel obj);
  Future <List<TransactionModel>> getAllTransaction();
}


class TransactionDB implements TransactionDbFunctions{

  TransactionDB._internal();
  static TransactionDB instance  = TransactionDB._internal();

  factory TransactionDB(){
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionList = ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final db = await Hive.openBox <TransactionModel>(TRANSACTION_DB_NAME);
     await db.put(obj.id, obj);
     print("transaction added ");
  }

  Future<void> refresh()async{
    final list =  await getAllTransaction();
    transactionList.value.clear();
    transactionList.value.addAll(list);
  }

  @override
  Future<List<TransactionModel>> getAllTransaction()async {
    final db = await Hive.openBox <TransactionModel>(TRANSACTION_DB_NAME);
    print("data is fetching ");
     return db.values.toList();
  }


  
}