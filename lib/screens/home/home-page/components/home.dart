import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/providers/courses_notifier.dart';
import 'package:st_school_app/screens/detail/detail_page.dart';
import 'package:st_school_app/widgets/custom_course_card.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({
    Key? key,
    required this.type,
  }) : super(key: key);
  final String type;
  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<CoursesNotifier>(context).findByCatogory(type);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(
        left: appPadding,
        right: appPadding - 10.0,
      ),
      child: Wrap(
        children: List.generate(courses!.length, (index) {
          var data = courses[index];

          return Padding(
            padding: const EdgeInsets.only(right: 15.0, bottom: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DetailPage.routeName,
                  arguments: data.id,
                );
              },
              child: CustomCourseCardExpand(
                thumbNail: data.image,
                videoAmount: data.videoTotal.toString(),
                title: data.name,
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
