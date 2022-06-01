import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/main.dart';
import 'package:st_school_app/screens/home/blog/blogs_page.dart';
import 'package:st_school_app/screens/home/blog/components/blog_details_page.dart';
import 'package:st_school_app/screens/home/home-page/home_page.dart';
import 'package:st_school_app/screens/home/my-courses/my-courses-page.dart';
import 'package:st_school_app/screens/home/profile/profile_page.dart';
import 'package:st_school_app/screens/home/setting/setting_page.dart';
import 'package:st_school_app/screens/home/search/searchs-page.dart';
import 'package:st_school_app/utils/valid.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  StreamSubscription<Map>? streamSubscription;
  StreamController<String> controllerData = StreamController<String>();
  StreamController<String> controllerInitSession = StreamController<String>();

  @override
  void initState() {
    listenDynamicLinks();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });

    super.initState();
  }

  void listenDynamicLinks() async {
    streamSubscription = FlutterBranchSdk.initSession().listen((data) {
      controllerData.sink.add((data.toString()));
      if (data.containsKey('+clicked_branch_link') &&
          data['+clicked_branch_link'] == true) {
        debugPrint(
            '------------------------------------Link clicked----------------------------------------------');
        debugPrint('Key: ${data['key'].toString()}');

        debugPrint('runtimeType: ${data['key'].runtimeType}');
        debugPrint(
            '------------------------------------------------------------------------------------------------');

        if (isNumeric(data['key']) && data['key'] != '-1') {
          Navigator.pushNamed(
            context,
            BlogDetailsPage.routeName,
            arguments: int.parse(data['key']),
          );
        }
      }
    }, onError: (error) {
      PlatformException platformException = error as PlatformException;
      debugPrint(
          'InitSession error: ${platformException.code} - ${platformException.message}');
      controllerInitSession.add(
          'InitSession error: ${platformException.code} - ${platformException.message}');
    });
  }

  List pages = [
    const HomePage(),
    const SearchsPage(),
    const MyCoursesPage(),
    const BlogPage(),
    const ProfilePage(),
    const SettingPage(),
  ];
  int _selectedIndex = 0;
  void onTapHandler(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: primary,
        elevation: 0.0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),
            label: 'Learning',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Blog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }
}
