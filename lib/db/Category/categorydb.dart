import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneypt/models/Category/categorymodel.dart';

const categoryname = "catrgory-model";

abstract class CategoryFunctions {
  Future<List<Categorymodel>> getcategies();
  Future<void> insertCategory(Categorymodel value);
  Future<void> deleteCategory(String onjectID);
}

class CategoryDB implements CategoryFunctions {
  CategoryDB._internal();
  static CategoryDB insurance = CategoryDB._internal();
  factory CategoryDB() {
    return insurance;
  }
  ValueNotifier<List<Categorymodel>> incomecategorylist = ValueNotifier([]);
  ValueNotifier<List<Categorymodel>> expensecategorylist = ValueNotifier([]);
  @override
  Future<void> insertCategory(Categorymodel value) async {
    final cateorydb = await Hive.openBox<Categorymodel>(categoryname);
    await cateorydb.put(value.id,value);
    refreshUI();
  }

  @override
  Future<List<Categorymodel>> getcategies() async {
    final cateorydb = await Hive.openBox<Categorymodel>(categoryname);
    return cateorydb.values.toList();
  }

  Future<void> refreshUI() async {
    final categorylist = await getcategies();
    incomecategorylist.value.clear();
    expensecategorylist.value.clear();
    Future.forEach(categorylist, (Categorymodel categorymodel) {
      if (categorymodel.type == CategoryType.income) {
        incomecategorylist.value.add(categorymodel);
      } else {
        expensecategorylist.value.add(categorymodel);
      }
    });
    incomecategorylist.notifyListeners();
    expensecategorylist.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String onjectID) async {
    final cateorydb = await Hive.openBox<Categorymodel>(categoryname);
    await cateorydb.delete(onjectID);
    refreshUI();
  }
}
