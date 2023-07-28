import 'package:flutter/material.dart';
import 'package:moneypt/db/Category/categorydb.dart';
import 'package:moneypt/screens/category/expensecategory.dart';
import 'package:moneypt/screens/category/incomecategory.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;
  @override
  void initState() {
    _tabcontroller = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TabBar(
          controller: _tabcontroller,
          unselectedLabelColor: Colors.black,
          labelColor: Colors.blue,
          tabs: const [Tab(text: "INCOME"), Tab(text: "EXPENSE")]),
      Expanded(
        child: TabBarView(
            controller: _tabcontroller,
            children: const [Incomecategorylist(), Expensecategorylist()]),
      )
    ]);
  }
}
