import 'package:flutter/material.dart';
import 'package:moneypt/db/Category/categorydb.dart';
import 'package:moneypt/db/Transaction/transactiondb.dart';
import 'package:moneypt/models/Category/categorymodel.dart';
import 'package:moneypt/models/Transaction/transactionmodel.dart';

class ScreenaddTransaction extends StatefulWidget {
  static const routeName = "addtransaction";
  const ScreenaddTransaction({super.key});

  @override
  State<ScreenaddTransaction> createState() => _ScreenaddTransactionState();
}

class _ScreenaddTransactionState extends State<ScreenaddTransaction> {
  CategoryType? selectedcategorytype;
  Categorymodel? selectedcategorymodel;
  String? selectedropdown;
  DateTime? selecteddate;
  final pusposeeditcontroller = TextEditingController();
  final amouteditcontroller = TextEditingController();
  @override
  void initState() {
    selectedcategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: pusposeeditcontroller,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(hintText: "purpose"),
            ),
            TextField(
              controller: amouteditcontroller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Amount"),
            ),
            TextButton.icon(
              onPressed: () async {
                final dateselected = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now());
                if (dateselected == null) {
                  return;
                } else {
                  setState(() {
                    selecteddate = dateselected;
                  });
                }
              },
              icon: const Icon(Icons.calendar_today),
              label: const Text("Select Date"),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Row(children: [
                Radio(
                    value: CategoryType.income,
                    groupValue: selectedcategorytype,
                    onChanged: (value) {
                      setState(() {
                        selectedcategorytype = CategoryType.income;
                        selectedropdown = null;
                      });
                    }),
                const Text("Income")
              ]),
              Row(children: [
                Radio(
                    value: CategoryType.expense,
                    groupValue: selectedcategorytype,
                    onChanged: (value) {
                      setState(() {
                        selectedcategorytype = CategoryType.expense;
                        selectedropdown = null;
                      });
                    }),
                const Text("Expense")
              ])
            ]),
            DropdownButton(
                hint: const Text("Select Items"),
                value: selectedropdown,
                items: (selectedcategorytype == CategoryType.income
                        ? CategoryDB().incomecategorylist
                        : CategoryDB().expensecategorylist)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: () {
                      selectedcategorymodel = e;
                      print("ontap $e");
                    },
                  );
                }).toList(),
                onChanged: (selectvalue) {
                  print("oncahnge $selectvalue");
                  setState(() {
                    selectedropdown = selectvalue;
                  });
                }),
            ElevatedButton(
                onPressed: () {
                  addTranscation();
                },
                child: const Text("Submit"))
          ],
        ),
      )),
    );
  }

  Future<void> addTranscation() async {
    final purpose = pusposeeditcontroller.text;
    final amount = amouteditcontroller.text;
    if (purpose.isEmpty) {
      return;
    }
    if (amount.isEmpty) {
      return;
    }

    if (selecteddate == null) {
      return;
    }
    if (selectedcategorymodel == null) {
      return;
    }
    final pasrseamount = double.tryParse(amount);
    if (pasrseamount == null) {
      return;
    }
    final model = TransactionModel(
        purpose: purpose,
        amount: pasrseamount,
        date: selecteddate!,
        type: selectedcategorytype!,
        category: selectedcategorymodel!);

    TransactionDB.instances.addTransaction(model);
  }
}
