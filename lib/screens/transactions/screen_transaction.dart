import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(10),
        itemBuilder:(BuildContext context , int count ){
      return const Card(
        color: Colors.black12,
        elevation: 0,
        child: ListTile(
          leading: CircleAvatar(
            radius: 50,
            child: Text(
              "12\n dec ",
              textAlign: TextAlign.center,
            ),
          ),
          title: Text('RS 100'),
          subtitle: Text("travel"),
        ),
      );
    }, separatorBuilder:(BuildContext context , int count ){
      return Divider();
    }, itemCount: 100);
  }
}
