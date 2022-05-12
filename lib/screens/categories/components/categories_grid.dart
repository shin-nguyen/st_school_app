import 'package:flutter/material.dart';
import 'package:st_school_app/models/course.dart';
import 'package:st_school_app/screens/categories/components/course_with_star.dart';
import 'package:st_school_app/screens/detail/detail_page.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({
    Key? key,
    required this.courses,
  }) : super(key: key);
  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        children: List.generate(courses.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(left: 4, right: 15.0, bottom: 20.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    DetailPage.routeName,
                    arguments: courses[index].id,
                  );
                },
                child: CourseStarCard(
                  course: courses[index],
                )),
          );
        }),
      ),
    );
  }
}
