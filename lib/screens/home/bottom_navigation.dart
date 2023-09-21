import 'package:flutter/material.dart';
import 'package:money_manager/screens/home/screen_home.dart';

class MoneyManageBottomNavigation extends StatelessWidget {
  const MoneyManageBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedInexNotifer,
      builder: (BuildContext context, int updatedIndex ,Widget?  _){
      return  BottomNavigationBar(
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.black,
        currentIndex:updatedIndex ,
        onTap: (newInedex){
        HomeScreen.selectedInexNotifer.value = newInedex;
        },
        items: const [
        BottomNavigationBarItem(label:"Transactions",icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: "Category", icon: Icon(Icons.category)),
        ]);
      },
    );
  }
}
