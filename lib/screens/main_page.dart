import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/screens/home_page.dart';
import 'package:st_school_app/screens/learning_page.dart';
import 'package:st_school_app/screens/profile_page.dart';
import 'package:st_school_app/screens/setting_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const HomePage(),
    const LearningPage(),
    const ProfilePage(),
    const SettingPage()
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: kpink,
              inactiveColor: Colors.grey[300]),
          BottomNavyBarItem(
            icon: Icon(Icons.auto_stories),
            title: Text('Learning'),
            inactiveColor: Colors.grey[300],
            activeColor: kpink,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            inactiveColor: Colors.grey[300],
            activeColor: kpink,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            inactiveColor: Colors.grey[300],
            activeColor: kpink,
          ),
        ],
      ),
    );
  }
}
