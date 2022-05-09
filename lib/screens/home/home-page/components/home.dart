import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/providers/courses_notifier.dart';
import 'package:st_school_app/widgets/custom_course_card.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<CoursesNotifier>(context).getCourses;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(
        left: appPadding,
        right: appPadding - 10.0,
      ),
      child: Wrap(
        children: List.generate(courses.length, (index) {
          var data = courses[index];

          return Padding(
            padding: const EdgeInsets.only(right: 15.0, bottom: 20.0),
            child: GestureDetector(
              child: CustomCourseCardExpand(
                thumbNail: data.image,
                videoAmount: data.videoTotal.toString(),
                title: data.description,
                userProfile:
                    'https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
                userName: data.lecturer,
                price: data.price.toString(),
              ),
            ),
          );
        }),
      ),
    );
  }
}
