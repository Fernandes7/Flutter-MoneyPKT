import 'package:flutter/material.dart';
import 'package:moneypt/screens/addtransaction/screenaddtransaction.dart';
import 'package:moneypt/screens/category/categoryaddpopup.dart';
import 'package:moneypt/screens/category/screencategory.dart';
import 'package:moneypt/screens/homes/widgets/bottomnavigation.dart';
import 'package:moneypt/screens/transaction/screentransaction.dart';

class Screenhome extends StatelessWidget {
  const Screenhome({super.key});
  static ValueNotifier<int> selectedindex = ValueNotifier(0);
  final _pages = const [ScreenTransactions(), ScreenCategory()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Money Manger App"),
          centerTitle: true,
        ),
        bottomNavigationBar: const MoneyMnagerBottomNavigation(),
        body: SafeArea(
            child: ValueListenableBuilder(
          valueListenable: selectedindex,
          builder: (BuildContext cxt, int pageindex, Widget? child) {
            return _pages[pageindex];
          },
        )),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (selectedindex.value == 0) {
                Navigator.of(context).pushNamed(ScreenaddTransaction.routeName);
              }
              else
              {
                showcategoryaddpopup(context);
              }
            },
            child: const Icon(Icons.add)));
  }
}
