import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneypt/models/Category/categorymodel.dart';
import 'package:moneypt/models/Transaction/transactionmodel.dart';
import 'package:moneypt/screens/addtransaction/screenaddtransaction.dart';
import 'package:moneypt/screens/homes/screenhome.dart';

Future<void> main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  if (!Hive.isAdapterRegistered(CategorymodelAdapter().typeId)) {
    Hive.registerAdapter(CategorymodelAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
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
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const Screenhome(),
        routes:{
          ScreenaddTransaction.routeName:(cxt)=>const ScreenaddTransaction()
        });
  }
}
