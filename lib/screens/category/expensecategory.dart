import 'package:flutter/material.dart';
import 'package:moneypt/db/Category/categorydb.dart';
import '../../models/Category/categorymodel.dart';

class Expensecategorylist extends StatelessWidget {
  const Expensecategorylist({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().expensecategorylist,
        builder: (BuildContext cxt, List<Categorymodel> newlist, Widget? _) {
          return ListView.separated(
              itemBuilder: (cxt, index) {
                final category = newlist[index];
                return ListTile(
                  title: Text(category.name),
                  subtitle: Text(category.type.toString()),
                   trailing:IconButton(onPressed: (){
                    CategoryDB().deleteCategory(category.id);
                   },icon:const Icon(Icons.delete))
                );
              },
              separatorBuilder: (cxt, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount:newlist.length);
        });
  }
}
