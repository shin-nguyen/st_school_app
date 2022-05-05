import 'package:flutter/material.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/screens/home/my-courses/components/my-courses.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({Key? key}) : super(key: key);

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      body: MyCourseList(),
    );
  }
}
