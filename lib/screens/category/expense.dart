import 'package:flutter/material.dart';
import 'package:money_manager/db/category/categor_db.dart';

import '../../models/category/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: CategoryDB().expenseCategoryList, builder: (BuildContext context, List<CategoryModel> newList , Widget? child){
      return  ListView.separated(
          padding:  const EdgeInsets.all(10),
          itemBuilder: (BuildContext context, index) {
            final eachItem = newList[index];
            return  Card(
              color: Colors.black12,
              elevation: 0,
              child: ListTile(
                title: const Text('Expense'),
                subtitle: Text(eachItem.name),
                trailing: const Icon(Icons.delete),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int count) {
            return const Divider();
          },
          itemCount: newList.length);
    });
  }
}
