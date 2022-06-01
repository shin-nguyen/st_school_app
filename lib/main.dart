import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/models/order.dart';
import 'package:st_school_app/models/user.dart';
import 'package:st_school_app/providers/auth_notifier.dart';
import 'package:st_school_app/providers/blogs_notifier.dart';
import 'package:st_school_app/providers/cart_notifier.dart';
import 'package:st_school_app/providers/courses_notifier.dart';
import 'package:st_school_app/providers/orders_notifier.dart';
import 'package:st_school_app/providers/user_notifier.dart';
import 'package:st_school_app/providers/video_notifier.dart';
import 'package:st_school_app/routes.dart';
import 'package:st_school_app/screens/home/main_page.dart';
import 'package:st_school_app/screens/login/login.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterBranchSdk.validateSDKIntegration();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // String? token = await FirebaseMessaging.instance.getToken();
  // print(token);
  runApp(const MyApp());
}

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
          ChangeNotifierProxyProvider<AuthNotifier, BlogsNotifier>(
            create: (context) => BlogsNotifier([]),
            update: (_, auth, previousBlogs) => BlogsNotifier(
              previousBlogs == null ? [] : previousBlogs.getBlogs,
            ),
          ),
          ChangeNotifierProxyProvider<AuthNotifier, OrdersNotifier>(
            create: (context) => OrdersNotifier(OrderItem.empty()),
            update: (_, auth, previousVideos) => OrdersNotifier(
              previousVideos == null
                  ? OrderItem.empty()
                  : previousVideos.orders,
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
