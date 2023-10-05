import 'package:flutter/material.dart';
import 'package:money_manager/screens/category/screen_category.dart';
import 'package:money_manager/screens/home/bottom_navigation.dart';
import 'package:money_manager/screens/transactions/screen_add_transaction.dart';

import '../../db/category/categor_db.dart';
import '../../models/category/category_model.dart';
import '../category/category_add_popup.dart';
import '../transactions/screen_transaction.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static ValueNotifier<int> selectedInexNotifer = ValueNotifier(0);
  final _pages = const [
    TransactionScreen(),
    CategoryScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Money Manager"),
      ),
      bottomNavigationBar: const MoneyManageBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(valueListenable: selectedInexNotifer, builder: (BuildContext context , int Index , Widget? _){
          return _pages[Index];
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          switch (selectedInexNotifer.value) {
            case 0:
              Navigator.of(context).pushNamed(ScreenaddTransaction.routeName);
              break;
            case 1:
              showCategoryAddPopup(context);
              break;
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
