import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/db/category/categor_db.dart';

import '../../models/category/category_model.dart';
import 'expense.dart';
import 'income.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> with SingleTickerProviderStateMixin {

 late TabController _tabController;
 List<CategoryModel> incomeList = List.empty(growable: true);
 List<CategoryModel> expenseList = List.empty(growable: true);


 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    List<CategoryModel> a;
     CategoryDB().refreshUI();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
            tabs: const [
          Tab(text:"INCOME" ,),
          Tab(text: "EXPENSE",)
        ],),
         Expanded(
           child: TabBarView(
              controller: _tabController, children: const [
             IcomeCategoryList(),
             ExpenseCategoryList()
        ]),
         )
      ],
    );
  }
}

