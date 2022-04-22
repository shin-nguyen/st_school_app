import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/providers/courses.dart';
import 'package:st_school_app/screens/course_overview_screen.dart';
import 'package:st_school_app/screens/detail_page.dart';
import 'package:st_school_app/screens/shop_page.dart';
import 'package:st_school_app/screens/login.dart';
import 'package:st_school_app/screens/main_page.dart';
import 'package:st_school_app/screens/sign_in/sign_in_screen.dart';
import 'package:st_school_app/screens/splash_screen.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          // ChangeNotifierProxyProvider<Auth, Courses>(
          //   update: (_, auth, previousProducts) => Courses(
          //       auth.token,
          //       auth.userId,
          //       previousProducts == null ? [] : previousProducts.getCourses),
          // ),

          // ChangeNotifierProvider(create: (context) => Courses(_, _, _)),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'ST School',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: auth.isAuth
                ? CoursesOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        // authResultSnapshot.connectionState ==
                        //         ConnectionState.waiting
                        //     ? SplashScreen()
                        // :
                        AuthScreen(),
                  ),
            routes: {
              MainPage.routeName: (ctx) => MainPage(),

              // '/home': (context) => const MainPage(),
              // '/login': (context) => const LoginPage(),
              // '/shop': (context) => const ShopPage(),
              // '/detail/1': (context) => const DetailPage()
            },
          ),
        ));
  }
}
