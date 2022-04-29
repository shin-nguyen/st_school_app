import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/providers/courses.dart';
import 'package:st_school_app/providers/user.dart';
import 'package:st_school_app/routes.dart';
import 'package:st_school_app/screens/login/login.dart';
import './providers/auth.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Courses>(
            create: (context) => Courses("", "", []),
            update: (_, auth, previousProducts) => Courses(
                auth.token!,
                auth.userId!,
                previousProducts == null ? [] : previousProducts.getCourses),
          ),
          ChangeNotifierProxyProvider<Auth, User>(
            create: (context) => User(
                id: 0, address: "", firstName: "", lastName: "", phone: ""),
            update: (_, auth, previousUser) => User(
                id: previousUser!.id,
                firstName: previousUser.firstName,
                lastName: previousUser.lastName,
                phone: previousUser.phone,
                address: previousUser.address),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'ST School',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            // home: auth.isAuth
            //     ? CoursesOverviewScreen()
            //     : FutureBuilder(
            //         future: auth.tryAutoLogin(),
            //         builder: (ctx, authResultSnapshot) =>
            //             // authResultSnapshot.connectionState ==
            //             //         ConnectionState.waiting
            //             //     ? SplashScreen()
            //             // :
            //             AuthScreen(),
            //       ),
            home: const LoginPage(),
            routes: routes,
          ),
        ));
  }
}
