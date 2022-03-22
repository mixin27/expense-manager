import 'package:expense_manager/db/offline_db_provider.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize the database when the application first runs
  OfflineDbProvider.provider.initDb();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Manager',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
