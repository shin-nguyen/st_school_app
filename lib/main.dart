import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/providers/courses.dart';
import 'package:st_school_app/screens/detail_page.dart';
import 'package:st_school_app/screens/shop_page.dart';
import 'package:st_school_app/screens/login.dart';
import 'package:st_school_app/screens/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Courses())],
      child: MaterialApp(
        title: 'ST School',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(),
        routes: {
          '/home': (context) => const MainPage(),
          '/login': (context) => const LoginPage(),
          '/shop': (context) => const ShopPage(),
          '/detail/1': (context) => const DetailPage()
        },
      ),
    );
  }
}
