import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/models/user.dart';
import 'package:st_school_app/providers/auth_notifier.dart';
import 'package:st_school_app/providers/cart_notifier.dart';
import 'package:st_school_app/providers/courses_notifier.dart';
import 'package:st_school_app/providers/user_notifier.dart';
import 'package:st_school_app/providers/video_notifier.dart';
import 'package:st_school_app/routes.dart';
import 'package:st_school_app/screens/home/main_page.dart';
import 'package:st_school_app/screens/login/login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: AuthNotifier(),
          ),
          ChangeNotifierProvider.value(
            value: CartNotifier(),
          ),
          ChangeNotifierProxyProvider<AuthNotifier, CoursesNotifier>(
            create: (context) => CoursesNotifier([], [], []),
            update: (_, auth, previousCourses) => CoursesNotifier(
              previousCourses == null ? [] : previousCourses.getCourses,
              previousCourses == null ? [] : previousCourses.getPromotions,
              previousCourses == null ? [] : previousCourses.getMyLearning,
            ),
          ),
          ChangeNotifierProxyProvider<AuthNotifier, UserNotifier>(
            create: (context) => UserNotifier(User.empty()),
            update: (_, auth, previousUser) =>
                UserNotifier(previousUser!.getUser),
          ),
          ChangeNotifierProxyProvider<AuthNotifier, VideosNotifier>(
            create: (context) => VideosNotifier([]),
            update: (_, auth, previousVideos) => VideosNotifier(
              previousVideos == null ? [] : previousVideos.getVideos,
            ),
          ),
        ],
        child: Consumer<AuthNotifier>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'ST School',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            home: auth.isAuth ? const MainPage() : const LoginPage(),
            routes: routes,
          ),
        ));
  }
}
