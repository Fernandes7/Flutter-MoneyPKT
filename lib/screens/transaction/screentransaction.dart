import 'package:flutter/material.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding:const  EdgeInsets.all(10),
        itemBuilder: (cxt, index) {
          return const  Card(
            child: ListTile(
              title: Text("100000rs"),
              subtitle: Text("Travel"),
              leading: Text("12 dec"),
              trailing:Icon(Icons.delete,color: Colors.red,),
            ),
          );
        },
        separatorBuilder: (cxt, index) {
          return const SizedBox(height: 10);
        },
        itemCount: 10);
  }
}
