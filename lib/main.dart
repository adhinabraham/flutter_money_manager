import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/db/category/categor_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/screens/home/screen_home.dart';
import 'package:money_manager/screens/transactions/screen_add_transaction.dart';

import 'models/transactions/transaction_model.dart';

Future <void> main() async {

  CategoryDB a = CategoryDB();
  CategoryDB b = CategoryDB();

  if( a == b ){
    print("true");
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)){
     Hive.registerAdapter(CategoryTypeAdapter());
  }
  if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if(!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)){
    Hive.registerAdapter(TransactionModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      routes: {
        ScreenaddTransaction.routeName: (context) => const ScreenaddTransaction()
      },
    );
  }
}


