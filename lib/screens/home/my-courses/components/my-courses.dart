import 'package:flutter/material.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/course.dart';
import 'package:st_school_app/screens/learning/learning_page.dart';
import 'package:st_school_app/widgets/custom_heading.dart';
import 'package:st_school_app/widgets/custom_my_courses_card.dart';

class MyCourseList extends StatelessWidget {
  const MyCourseList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(appPadding),
      child: Column(children: [
        const SizedBox(height: spacer - 1.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const CustomHeading(
                title: 'My Courses',
                subTitle: 'Let\'s continue, shall we?',
                color: secondary),
            Text(
              5.toString() + ' Courses',
              style: const TextStyle(color: secondary, fontSize: 15.0),
            ),
          ],
        ),
        const SizedBox(height: spacer),
        Column(
          children: List.generate(courses.length, (index) {
            var course = courses[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, LearningPage.routeName),
                child: CustomMyCoursesCard(
                  image: course.image,
                  title: course.description,
                  instructor: course.lecturer,
                  videoAmount: "12",
                  percentage: 30.0,
                ),
              ),
            );
          }),
        ),
      ]),
    );
  }
}
