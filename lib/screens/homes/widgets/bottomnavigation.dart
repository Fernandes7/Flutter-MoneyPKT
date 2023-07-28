import 'package:flutter/material.dart';
import 'package:moneypt/screens/homes/screenhome.dart';

class MoneyMnagerBottomNavigation extends StatelessWidget {
  const MoneyMnagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Screenhome.selectedindex,
        builder: (BuildContext cxt, int updatedindex,Widget? child) {
          return BottomNavigationBar(
             selectedItemColor: Colors.green[800],
             unselectedItemColor: Colors.black,
              currentIndex: updatedindex,
              onTap: (index) {
                Screenhome.selectedindex.value = index;
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: "Transactions"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: "Category")
              ]);
        });
  }
}
