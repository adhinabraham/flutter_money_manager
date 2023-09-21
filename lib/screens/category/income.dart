import 'package:flutter/material.dart';

import '../../db/category/categor_db.dart';
import '../../models/category/category_model.dart';

class IcomeCategoryList extends StatelessWidget {
  const IcomeCategoryList({super.key});


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: CategoryDB().incomeCategoryList, builder: (BuildContext context, List<CategoryModel> newList , Widget? child){
      return  ListView.separated(
          padding:  const EdgeInsets.all(10),
          itemBuilder: (BuildContext context, index) {
            final eachItem = newList[index];
            return  Card(
              color: Colors.black12,
              elevation: 0,
              child: ListTile(
                title: Text(eachItem.name),
                trailing: IconButton(onPressed: (){
                  CategoryDB.instance.deleteCategory(eachItem.id);
                },icon: const Icon(Icons.delete)),
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