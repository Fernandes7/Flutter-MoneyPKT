import 'package:flutter/material.dart';
import 'package:moneypt/db/Category/categorydb.dart';
import 'package:moneypt/models/Category/categorymodel.dart';

ValueNotifier<CategoryType> selectedcategory =
    ValueNotifier(CategoryType.income);

Future<void> showcategoryaddpopup(BuildContext context) async {
  final newtextcontroller = TextEditingController();
  showDialog(
      context: context,
      builder: (cxt) {
        return SimpleDialog(
          title: const Text("Add Category", textAlign: TextAlign.center),
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                    controller: newtextcontroller,
                    decoration: const InputDecoration(
                        hintText: "Ctegory Name",
                        border: OutlineInputBorder()))),
            Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () {
                      final name = newtextcontroller.text;
                      if (name.isEmpty) {
                        return;
                      }
                        final type = selectedcategory.value;
                        final categerytoadd = Categorymodel(
                            name: name,
                            type: type,
                            id: DateTime.now().toString());
                        CategoryDB().insertCategory(categerytoadd);
                        Navigator.of(cxt).pop();
                    },
                    child: const Text("Add It "))),
            const Padding(
                padding: EdgeInsets.all(10),
                child: Row(children: [
                  Radiobuttonselect(title: "income", type: CategoryType.income),
                  Radiobuttonselect(
                      title: "Expense", type: CategoryType.expense)
                ]))
          ],
        );
      });
}

class Radiobuttonselect extends StatelessWidget {
  final String title;
  final CategoryType type;
  const Radiobuttonselect({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedcategory,
            builder: (BuildContext ctx, CategoryType newcategory, Widget? _) {
              return Radio<CategoryType>(
                  value: type,
                  groupValue: newcategory,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    } else {
                      selectedcategory.value = value;
                      selectedcategory.notifyListeners();
                    }
                  });
            }),
        Text(title)
      ],
    );
  }
}
