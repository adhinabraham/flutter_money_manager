import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/category/categor_db.dart';
import 'package:money_manager/db/transaction/transaction_db.dart';
import 'package:money_manager/models/category/category_model.dart';

import '../../models/transactions/transaction_model.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(valueListenable: TransactionDB.instance.transactionList,
        builder:(BuildContext ctx,List<TransactionModel> newList,Widget? widget){ return ListView.separated(
            itemCount:TransactionDB.instance.transactionList.value.length,
            padding: const EdgeInsets.all(10),
            itemBuilder:(BuildContext context , int index  ){
              final _value = newList[index];
              return  Card(
                color: Colors.black12,
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _value.transActionType == CategoryType.income? Colors.amber:Colors.deepOrange,
                    radius: 50,
                    child: Text(
                      parseDate(_value.transactionDate),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  title: Text('RS ${_value.amount}'),
                  subtitle: Text(_value.transActionType.name),
                  trailing:  IconButton(
                    icon: Icon(Icons.delete),
                    iconSize: 24.0,
                    color: Colors.red,
                    onPressed: (){
                      TransactionDB.instance.deleteTransaction(_value);
                    },
                  ),
                ),
              );
            }, separatorBuilder:(BuildContext context , int count ){
          return Divider();
        },);});
  }

  String parseDate (DateTime data) {
    final date = DateFormat.MMMd().format(data);
    final splitedData = date.split(" ");
    return ("${splitedData.last}\n ${splitedData.first}");
  }
}
