import 'package:flutter/material.dart';
import 'package:st_school_app/screens/home/my-courses/components/my-courses.dart';
import 'package:st_school_app/widgets/appbar.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({Key? key}) : super(key: key);

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 230, 230, 230)),
            child: ListView(children: [
              CustomeAppBar(),
              const SizedBox(
                height: 20,
              ),
              // Sorting(),
              MyCourseList()
            ])));
  }
}
